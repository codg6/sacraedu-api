# Progresso — 14/10/2026

## Fundação previamente preparada

- Nome sacraedu-api no pom e nas configurações Spring.
- Base Maven, configurações Spring e Compose PostgreSQL 17 persistente.
- Roles separadas e perfis local/neon; arquivos de exemplo sem senhas.
- Instruções, requisitos, arquitetura, diretrizes e sprints planejadas.
- A validação anterior dos artefatos não comprova execução operacional do banco ou da aplicação.

## Sprint 00 — descoberta e contrato de escopo

### Decisões confirmadas pelo usuário

- Organização escolar é o tenant e poderá conter uma ou várias unidades.
- Uma organização não pode ver nem saber da existência de outra.
- O cadastro de organização cria automaticamente um administrador que vê todos os dados daquela organização.
- Há um superadministrador, dono do sistema, com acesso a todo o sistema e às organizações. Dashboard de monitoramento e auditoria é trabalho futuro.
- Os demais perfis serão definidos em sprints posteriores.
- A intenção para o início do produto é CRUD de todas as modalidades; as regras acadêmicas virão depois.
- Regras acadêmicas e escopo detalhado da Pastoral ainda não estão definidos.

### Documentos alterados ou criados nesta Sprint 00

- AGENTS.md
- docs/requisitos.md
- docs/arquitetura.md
- docs/diretrizes.md
- docs/glossario.md
- docs/historias-v1.md
- docs/matriz-permissoes-v1.md
- docs/mapa-modulos-v1.md
- docs/backlog-v1.md
- docs/adr/README.md
- docs/adr/ADR-001-organizacao-como-tenant.md
- docs/sprints/sprint-00.md
- docs/progresso.md

### Critérios e pendências

- Escopo/exclusões: limites e exclusões documentados; o catálogo exato do CRUD ainda precisa de validação.
- Isolamento de organizações: decisão documentada; nenhum controle foi implementado ou testado.
- Matriz de permissões: criada como rascunho revisável; operações de escrita e perfis futuros permanecem pendentes.
- Glossário, histórias, mapa de módulos, backlog e propostas de ADR: criados como artefatos de descoberta, distinguindo confirmado de pendente.
- Regras acadêmicas, Pastoral, cadastro e onboarding do administrador, volumes, desempenho, retenção e aceite final da v1: pendentes.
- Sprint 00 foi aceita e finalizada pelo usuário em 14/10/2026. Os detalhes marcados como ainda não definidos ficam registrados como pendências que bloqueiam apenas os fluxos correspondentes nas sprints futuras.
- Sprint 01 não iniciada.

### Comandos e evidências desta execução

- Leitura de AGENTS.md, README.md, requisitos, arquitetura, diretrizes, progresso, Sprint 00, pom.xml, configurações e BANCO-LOCAL.md concluída.
- Listagem de arquivos com rg --files concluída.
- Na inspeção inicial, git status e git rev-parse falharam porque não havia repositório Git. A pedido do usuário, git init, git branch -M main e git remote add origin foram executados depois; a branch local é main e origin aponta para a URL fornecida.
- Como este é o primeiro commit do repositório, ele registra a base versionável já presente junto com os documentos da Sprint 00. O arquivo local .env não existe; .gitignore exclui esse arquivo e .env.example contém somente campos vazios.
- O usuário confirmou o aceite em 14/10/2026 e o commit local foi criado depois desse aceite. O estado da publicação em origin/main está registrado após o push.
- Nenhum build, teste, comando Docker, acesso ao banco ou conexão cloud foi executado nesta Sprint 00.
- Não há classe principal Java, endpoints, autenticação ou isolamento tenant implementados.

### Explicação didática e demonstração

Tenant é a fronteira que separa os dados de cada cliente. Neste projeto, a organização é essa fronteira e as unidades ficam dentro dela. O Spring aplicará autenticação e autorização, mas os vínculos e verificações de acesso serão regras implementadas pela aplicação. O PostgreSQL preservará integridade e transações. O superadministrador será uma permissão global explícita; uma requisição sem contexto válido continua negada.

Esta sprint é documental e não tem demonstração executável de API.

## Modelo de registro por sprint futura

- Escopo executado e aceite:
- Decisões confirmadas e pendentes:
- Arquivos alterados:
- Comandos/testes executados e resultados reais:
- Critérios atendidos e não atendidos:
- Bloqueios e riscos:
- Demonstração e explicação didática:
- Commit criado após conclusão e validação:
