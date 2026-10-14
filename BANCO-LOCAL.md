# PostgreSQL local persistente

## Preparar uma vez

Instale/inicie Docker com suporte a Compose. Na pasta deste projeto, copie `.env.example` para `.env` e preencha três senhas diferentes, longas e alfanuméricas. Não publique esse arquivo. PowerShell: `Copy-Item .env.example .env`. Bash: `cp .env.example .env`.

Execute na mesma pasta:

```sh
docker compose up -d postgres
docker compose ps
```

Banco: sacra_edu. Host: localhost. Porta padrão: 5432. Aplicação usa sacra_app; Flyway usa sacra_migrator. O administrador postgres é apenas para provisionamento/manutenção, não para a API. O volume possui nome fixo sacra-edu-postgres-data, assim como projeto e container; se já houver um recurso incompatível com esse nome, pare e investigue sem removê-lo.

Para parar preservando dados:

```sh
docker compose stop postgres
```

Para retomar, execute novamente `docker compose up -d postgres`. Não usar comandos que apagam volumes ou limpam o banco. Mudar nome do volume, host Docker ou diretório de dados não migra os dados existentes. A persistência pertence ao Docker host atual e não é backup.

A primeira inicialização cria o banco e suas roles. O script de provisionamento não é uma migration de negócio: configura privilégios da infraestrutura, sem criar tabelas ou dados escolares. Reinícios não o executam de novo. Migrações futuras devem conceder privilégios específicos à role sacra_app sobre suas tabelas/sequências. Não conceder DDL à aplicação.

Alterar uma senha no .env após a inicialização NÃO altera a senha armazenada no PostgreSQL. Para trocar senha, fazer rotação controlada; nunca apagar o volume para resolver autenticação. Se a inicialização falhar parcialmente, investigar e reparar explicitamente; não fazer reset automático.

## Aplicação local

O perfil padrão é local e importa o .env da pasta de trabalho como properties. Execute a futura aplicação com essa pasta como working directory (inclusive na IDE). Ainda não há classe principal nesta fundação; não foi implementado startup da API. O mesmo arquivo serve ao Compose e ao Spring. Use a sintaxe simples orientada no exemplo para evitar divergência entre os parsers. Variáveis do processo podem sobrepor esses valores.

Hibernate continua validate; Flyway usa migrations incrementais em db/migration e clean permanece desativado. Não há seeds nem exclusão automática. Limpeza de dados requer pedido do usuário ou autorização específica após explicar motivo e alcance.

## Neon somente quando solicitada

Ativar exclusivamente SPRING_PROFILES_ACTIVE=neon e fornecer as seis variáveis NEON_* documentadas. Não ativar local e neon simultaneamente. Esse perfil não importa .env local. A configuração não copia ou sincroniza dados entre ambientes. Nenhuma conexão Neon foi realizada.

## Validação e limites

YAML, XML e sintaxe Bash conferidos. Docker não está instalado no ambiente desta entrega, então o container não foi iniciado, nem foram executados testes reais de conexão, privilégios ou persistência. Esses testes serão feitos no ambiente local com Docker antes de considerar a fundação operacional. Não foi criado outro banco nem alterado qualquer banco existente.

Referências: https://docs.docker.com/guides/postgresql/ e https://docs.spring.io/spring-boot/3.5/reference/features/profiles.html
