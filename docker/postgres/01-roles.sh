#!/usr/bin/env bash
# Provisiona SOMENTE roles e permissões na primeira inicialização do volume.
# Tabelas de negócio serão criadas exclusivamente pelo Flyway.
set -euo pipefail
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" \
  --set=ON_ERROR_STOP=1 \
  --set=app_password="$LOCAL_APP_PASSWORD" \
  --set=migration_password="$LOCAL_MIGRATION_PASSWORD" <<'SQL'
CREATE ROLE sacra_migrator LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD :'migration_password';
CREATE ROLE sacra_app LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE PASSWORD :'app_password';
REVOKE ALL ON DATABASE sacra_edu FROM PUBLIC;
GRANT CONNECT ON DATABASE sacra_edu TO sacra_app, sacra_migrator;
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
GRANT USAGE, CREATE ON SCHEMA public TO sacra_migrator;
GRANT USAGE ON SCHEMA public TO sacra_app;
-- Cada migration concederá explicitamente acesso às tabelas de negócio.
-- Não concedemos acesso automático à tabela de histórico do Flyway.
SQL
