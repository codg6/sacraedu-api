# Instruções do projeto sacraedu-api

Estas instruções se aplicam a todo o repositório. São orientações para o agente; não substituem controles de acesso e CI. Instruções explícitas atuais do usuário prevalecem; se mudarem uma decisão registrada, documentar a mudança sem ocultar o impacto.

## Antes de alterar arquivos

1. Leia README.md, docs/requisitos.md, docs/arquitetura.md, docs/diretrizes.md e docs/progresso.md.
2. Leia o documento da sprint solicitada em docs/sprints e verifique seus pré-requisitos. Se não houver sprint solicitada, não iniciar implementação por inferência; apresentar estado e próximo passo.
3. Inspecione o código e alterações locais; preserve o trabalho existente. Resuma objetivo, regras aplicáveis e pendências materiais.
4. Execute somente a sprint solicitada. Não avance automaticamente à próxima. A Sprint 00 é definição de requisitos, não implementação do sistema.

## Identidade e escopo

Nome técnico: sacraedu-api; groupId: br.com.sacracod; pacote Java: br.com.sacracod.sacraedu. Java 21, Spring Boot 3.4+ (fundação 3.5.16, verificar suporte antes da implementação), Maven, PostgreSQL, Spring Data JPA e Spring Security. Monólito modular com uma aplicação executável. O pom inicial ainda não é multimódulo: estruturar parent e filhos na Sprint 01, preservando recursos e documentação.

Segurança com componentes oficiais do Spring, servidor de autorização próprio, OAuth2/OIDC e JWT. Não usar Keycloak, identidade externa ou criptografia própria. Pastoral opcional, sem dependência obrigatória no núcleo acadêmico. Sem segunda API, microsserviços, frontend ou mobile nesta fase. Não inventar regras escolares nem promover propostas a decisões.

## Banco persistente — regra obrigatória

PostgreSQL local em Docker é padrão. Reutilizar banco sacra_edu, container sacra-edu-postgres-local e volume sacra-edu-postgres-data. Não renomear recursos para contornar falhas; não criar outra cópia permanente. Não executar limpeza de dados, remover volumes ou reinicializar o banco sem pedido explícito ou autorização específica do usuário após explicar motivo e alcance. Nunca gerar DROP TABLE ou DROP DATABASE. Não executar seeds automáticos que dupliquem dados.

Migrations somente SQL via Flyway, ddl-auto=validate, clean desativado; não alterar migrations já aplicadas. Preservar constraints e privilégios mínimos. Testes destrutivos usam banco temporário isolado, nunca o banco de desenvolvimento. Neon apenas com perfil neon e solicitação explícita de teste cloud. Não copiar dados entre ambientes automaticamente. Consultar BANCO-LOCAL.md antes de comandos Docker.

## Isolamento e segurança

Tenant obrigatório nos dados do cliente: a organização escolar é o tenant e pode ter uma ou várias unidades. Usuários de uma organização não podem consultar nem descobrir outras organizações. O superadministrador, dono do sistema, tem acesso global como exceção explícita; ausência de contexto nunca concede esse acesso. Contexto validado por vínculo/autorização autenticada; header/DTO não concede permissão. Limpar ThreadLocal em finally e tratar async explicitamente. Filtros Hibernate não bastam: proteger IDs, inserts, updates/deletes, SQL nativo, bulk, cache e jobs. Negar operações sem contexto válido. Testes entre duas organizações/unidades são obrigatórios nos fluxos afetados. RLS não será adicionado automaticamente; avaliação futura deve ser documentada.

Não registrar senhas, tokens ou dados pessoais nos logs. Não versionar segredos. Não desativar segurança, validação ou testes para aprovar uma entrega. Índices compostos seguem consultas reais; não prometer ausência de varreduras sequenciais.

## Trabalho didático e critérios de avanço

Explique conceitos novos em português e diferencie responsabilidade do Spring e do nosso código. Comente decisões e regras relevantes, sem comentários triviais. Trabalhe em incrementos coerentes: vários arquivos podem ser necessários para uma alteração funcional. Decisões técnicas reversíveis dentro do escopo podem prosseguir; regras de negócio pendentes exigem esclarecimento.

Respeite os gates documentados. Não altere critérios, CI, testes ou proteções de branch para esconder falhas. Registre mudanças nesses mecanismos para revisão. Não aprove seu próprio PR em nome do usuário. Não publicar nem mudar produção sem instrução.

## Encerramento de cada sprint

Atualize docs/progresso.md com arquivos alterados, critérios atendidos/pendentes, comandos executados, resultados reais e bloqueios. Inclua explicação didática e demonstração executável quando aplicável. Teste não executado permanece pendente. Só declare concluído com evidência; solicite aceite da entrega concreta antes de avançar. Depois que o usuário validar e a sprint estiver finalizada, faça um commit local somente com as alterações daquela sprint. Não faça commit de sprint ainda aberta nem inclua alterações não relacionadas. Publicar/push exige instrução explícita. Nunca alegue que gates documentados já estão automatizados.
