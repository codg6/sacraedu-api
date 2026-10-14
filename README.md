# sacraedu-api

Fundação e instruções para a API do SacraEdu. Comece pelo AGENTS.md e pela Sprint 00; o sistema ainda não está implementado.

## Colocar na raiz

Este ZIP não contém uma pasta externa: extraia seu conteúdo dentro da pasta sacraedu-api. AGENTS.md, README.md, pom.xml e compose.yml devem ficar diretamente nessa raiz. Se houver arquivos modificados na pasta, compare antes de substituir. Não substitua seu .env nem remova dados Docker.

## Iniciar com o Codex

Abra a pasta sacraedu-api e envie:

> Leia o AGENTS.md da raiz e os documentos indicados. Execute somente a Sprint 00 em docs/sprints/sprint-00.md. Resuma as decisões confirmadas e levante as pendências de negócio em pequenos grupos. Não implemente o backend nem avance para a Sprint 01 antes de validarmos o escopo.

Para outra sprint, substitua o número apenas depois dos pré-requisitos e do aceite. A instrução pede que o agente consulte o estado real do projeto; não depende da memória desta conversa.

## Arquivos principais

- [AGENTS.md](AGENTS.md): regras permanentes para o agente.
- [Requisitos](docs/requisitos.md): confirmado versus pendente.
- [Arquitetura](docs/arquitetura.md): limites e módulos.
- [Diretrizes e gates](docs/diretrizes.md): controles e evidências.
- [Progresso](docs/progresso.md): o que foi e não foi validado.
- [Glossário](docs/glossario.md): termos confirmados e pendentes.
- [Histórias v1](docs/historias-v1.md): exemplos iniciais, ainda sujeitos ao aceite.
- [Matriz de permissões](docs/matriz-permissoes-v1.md): fronteiras confirmadas e permissões pendentes.
- [Mapa de módulos](docs/mapa-modulos-v1.md) e [backlog proposto](docs/backlog-v1.md).
- [Propostas de ADRs](docs/adr/README.md): decisões arquiteturais registradas ou aguardando detalhamento.
- [Banco local](BANCO-LOCAL.md): preparação, execução e preservação de dados.

## Sprints

- [Sprint 00](docs/sprints/sprint-00.md)
- [Sprint 01](docs/sprints/sprint-01.md)
- [Sprint 02](docs/sprints/sprint-02.md)
- [Sprint 03](docs/sprints/sprint-03.md)
- [Sprint 04](docs/sprints/sprint-04.md)
- [Sprint 05](docs/sprints/sprint-05.md)
- [Sprint 06](docs/sprints/sprint-06.md)
- [Sprint 07](docs/sprints/sprint-07.md)
- [Sprint 08](docs/sprints/sprint-08.md)
- [Sprint 09](docs/sprints/sprint-09.md)
- [Sprint 10](docs/sprints/sprint-10.md)
- [Sprint 11](docs/sprints/sprint-11.md)
- [Sprint 12](docs/sprints/sprint-12.md)

## Banco local quando necessário

Copie .env.example para .env e defina três senhas distintas. Consulte BANCO-LOCAL.md antes de iniciar. Use docker compose up -d postgres para iniciar/reutilizar e docker compose stop postgres para parar preservando dados. Nada deve limpar ou duplicar o banco automaticamente.

Neon somente no perfil explícito neon. O perfil local carrega .env da pasta de trabalho; não versionar segredos. Ainda não há classe principal para executar a API. Os gates estão documentados; implementação e configuração de CI são trabalho da Sprint 01.
