# Sprint 00 — Descoberta e contrato de escopo

Revisão 3 — 14/10/2026. Inclui decisões recebidas e artefatos de descoberta; não comprova conclusão da sprint.

## Objetivo e escopo

Definir formalmente os gates, registrar regras permanentes no AGENTS.md e revisar quais módulos integram a v1. Financeiro, cobrança SaaS, biblioteca, transporte e cantina não estão implicitamente incluídos; se necessários, planejar sprints próprias antes de considerar a API completa. Consolidar requisitos e decisões em documentos versionáveis. Distinguir confirmado, proposto e pendente. Levantar organização/mantenedora/unidade; tipos e etapas escolares iniciais; papéis e acesso de responsáveis; regras de matrícula, notas e frequência; dados pastorais permitidos; critérios de conclusão da primeira versão. Perguntar em pequenos grupos somente o que muda a modelagem. Criar glossário, histórias com exemplos, matriz inicial de permissões, mapa de módulos e backlog priorizado. Definir volume esperado e metas de desempenho como pendentes até haver dados. Propor documentos de decisões (ADRs) e instruções AGENTS.md para o repositório; não criar uma skill.

## Dependência

Nenhuma. É uma sprint de análise, sem código de produção.

## Critérios de aceite

Escopo da v1 e exclusões explícitos; pendências que bloqueiam implementação identificadas; matriz de acesso revisável; nenhum requisito proposto tratado como aprovado. Não fechar a sprint até o usuário validar as decisões materiais.

## Aprendizado

Requisitos, domínio, critérios de aceite e diferença entre proposta e decisão.

## Prompt independente — copiar e executar

```text
Você está trabalhando no SacraEdu, SaaS escolar com foco em escolas católicas e módulo Pastoral opcional. Execute somente esta sprint. Leia primeiro AGENTS.md, README, decisões de arquitetura, modelo de dados e o estado das sprints que existirem no repositório. Se o repositório não estiver acessível, informe isso e não alegue implementação ou testes. Preserve alterações existentes.

Decisões: Java 21, Spring Boot 3.4+ (linha 3.5.x na fundação, verificar compatibilidade e suporte), PostgreSQL local em Docker; Neon apenas no perfil cloud, Maven multimódulo, monólito modular com uma aplicação executável. Segurança própria com Spring Security e servidor de autorização Spring, OAuth2/OIDC e JWT. Sem Keycloak ou provedor externo de identidade. Não criar microsserviços, segunda API de backup/exportação, frontend completo, filas ou infraestrutura distribuída sem necessidade demonstrada. BFF é uma decisão de integração web a documentar; não criar outro serviço agora. Decisão confirmada pelo usuário: organização escolar é o tenant e pode ter uma ou várias unidades; cada organização é invisível para as demais. Pastoral não pode ser dependência obrigatória do núcleo acadêmico.

GATES OBRIGATÓRIOS:
1. Entrada: ler decisões, progresso e escopo aprovado; diferenciar confirmado, proposto e pendente. Não inventar regras escolares. Na Sprint 00, validar o escopo antes de fechá-la.
2. Escopo: trabalhar apenas nesta sprint; alterações relevantes de arquitetura, dependências ou regras precisam de justificativa e decisão explícita. Pequenos ajustes técnicos reversíveis dentro do escopo podem prosseguir.
3. Arquitetura: respeitar encapsulamento dos módulos e proibir ciclos; não introduzir microsserviços ou serviços externos de identidade.
4. Segurança: negar por padrão e demonstrar isolamento entre tenants/unidades/registros com testes negativos. Não remover ou afrouxar controles/testes para passar.
5. Banco: migrations SQL manuais no Flyway; ddl-auto=validate; clean desativado; nunca gerar DROP TABLE ou DROP DATABASE. Não editar migrations aplicadas. Manter constraints e índices compostos adequados às consultas; índices não garantem ausência de varredura sequencial.
6. Evidências: registrar comandos e resultados realmente obtidos, testes não executados, limites e pendências. Critério não executado é pendente, não aprovado.
7. Aceite: apresentar diff, explicação e demonstração; parar ao concluir a sprint e aguardar aceite para a seguinte. CI e proteção de branch serão configurados na Sprint 01 conforme ambiente disponível; não alegar que AGENTS.md ou este prompt os substitui. Mudanças nos gates, CI e critérios devem ser explicitadas e revisadas, nunca usadas para esconder falhas.

PERSISTÊNCIA E AMBIENTES:
Java 21. PostgreSQL local via Docker é o padrão, um banco sacra_edu, container sacra-edu-postgres-local e volume persistente sacra-edu-postgres-data. Reutilizar os recursos existentes, sem renomear/criar outro banco para contornar erros. Não apagar volumes, dados ou recriar banco ao iniciar/sair de uma sprint. Limpeza exige pedido do usuário ou aprovação específica com motivo e alcance. Não executar seeds automáticos que dupliquem dados. Flyway é incremental. Neon só no perfil neon explicitamente ativado para testes cloud, sem cópia/sincronização automática. Testes que precisem escrever/apagar dados usam PostgreSQL temporário isolado, nunca o banco persistente de desenvolvimento; descartá-lo ao terminar. Testcontainers não é uma cópia permanente. Não conectar à Neon por iniciativa própria.

ISOLAMENTO:
Usar tenant_id obrigatório nas entidades de cliente e inventário explícito de exceções globais. Decisão confirmada na Sprint 00: tenant é a organização escolar; unidade pertence à organização. O superadministrador global é exceção explicitamente autorizada, nunca representada pela ausência de contexto. Contexto ThreadLocal validado a partir de identidade e vínculo/autorização, limpo em finally e tratado explicitamente em jobs/async. Filtros Hibernate são auxiliares: proteger também inserts, consultas por ID, SQL nativo, bulk, cache e gravações. Ausência de contexto válido nega acesso. Não implementar RLS automaticamente nesta versão; reavaliá-lo como defesa adicional antes da produção, com decisão documentada. A lógica de negócio e limites transacionais ficam no Spring, com integridade e atomicidade executadas pelo PostgreSQL.

Modo didático obrigatório: explique o problema antes da alteração; defina termos técnicos novos; comente em português decisões, regras e pontos de segurança, sem comentar trivialidades. Mostre um fluxo concreto, distinguindo o que o Spring faz do que implementamos. Inclua instruções de execução para Windows/PowerShell e alternativa Unix quando necessário. Use exemplos fictícios.

Qualidade: testes de regras e de autorização, integração com PostgreSQL real/Testcontainers quando aplicável, migrações Flyway e OpenAPI atualizado. Negar acesso por padrão, validar organização/unidade/registro, evitar entidades JPA expostas e segredos no código. Não invente regras escolares. Consulte documentação oficial para compatibilidade de versões e mecanismos de segurança e registre versões fixadas. Não enfraqueça controles para fazer testes passarem.

Trabalhe em incrementos pequenos nesta sprint. Prossiga em decisões técnicas reversíveis; pergunte apenas sobre ambiguidades materiais de negócio. Não implemente sprints futuras. No encerramento, entregue resumo, arquivos alterados, comandos executados e resultados reais, limitações, critérios de aceite atendidos e pendentes, explicação didática e exemplos de requisição sem segredos. Atualize docs/progresso.md e docs/sprints/ com evidências. Não declare conclusão se critérios falharem ou testes essenciais não puderem ser executados. Não publique nem altere produção.

SPRINT 00: Descoberta e contrato de escopo
PRÉ-REQUISITOS: Nenhuma. É uma sprint de análise, sem código de produção.

TRABALHO DESTA SPRINT:
Definir formalmente os gates, registrar regras permanentes no AGENTS.md e revisar quais módulos integram a v1. Financeiro, cobrança SaaS, biblioteca, transporte e cantina não estão implicitamente incluídos; se necessários, planejar sprints próprias antes de considerar a API completa. Consolidar requisitos e decisões em documentos versionáveis. Distinguir confirmado, proposto e pendente. Levantar organização/mantenedora/unidade; tipos e etapas escolares iniciais; papéis e acesso de responsáveis; regras de matrícula, notas e frequência; dados pastorais permitidos; critérios de conclusão da primeira versão. Perguntar em pequenos grupos somente o que muda a modelagem. Criar glossário, histórias com exemplos, matriz inicial de permissões, mapa de módulos e backlog priorizado. Definir volume esperado e metas de desempenho como pendentes até haver dados. Propor documentos de decisões (ADRs) e instruções AGENTS.md para o repositório; não criar uma skill.

CRITÉRIOS DE ACEITE:
Escopo da v1 e exclusões explícitos; pendências que bloqueiam implementação identificadas; matriz de acesso revisável; nenhum requisito proposto tratado como aprovado. Não fechar a sprint até o usuário validar as decisões materiais.

EXPLIQUE AO USUÁRIO:
Requisitos, domínio, critérios de aceite e diferença entre proposta e decisão.

Se os pré-requisitos não estiverem atendidos, identifique o que falta e não simule conclusão. Ao terminar, pare nesta sprint e deixe um resumo para a próxima sessão.

```

## Registro da execução — 14/10/2026

### Decisões recebidas

- Organização escolar é o tenant e pode ter várias unidades.
- Uma organização nunca deve ver nem saber da existência de outra.
- Ao cadastrar uma organização, será criado automaticamente seu administrador, que poderá ver todos os dados da organização.
- Haverá um superadministrador, dono do sistema, com acesso global. Dashboard de monitoramento e auditoria foi indicado como trabalho futuro.
- Outros perfis serão criados em sprints futuras.
- O foco inicial de ensino é CRUD de todas as modalidades; as regras acadêmicas serão desenvolvidas depois.
- Regras acadêmicas e detalhes da Pastoral ainda não estão definidos.

### Artefatos desta execução

Requisitos, glossário, histórias com exemplos, matriz revisável de permissões, mapa de módulos, backlog priorizado, índice de ADRs e ADR de organização como tenant foram criados ou atualizados. AGENTS.md e progresso.md também foram atualizados. Consulte progresso.md para evidências e limitações.

### Critérios e estado

- Documentos distinguem confirmado, proposto e pendente.
- Limites de tenant e exclusões estão registrados.
- Matriz de permissões está pronta para revisão, mas as permissões de escrita do administrador da organização e os perfis futuros estão pendentes.
- Catálogo de modalidades, onboarding do administrador, regras acadêmicas, Pastoral e critérios de aceite da v1 continuam pendentes.
- Você confirmou o aceite do contrato documental em 14/10/2026; Sprint 00 finalizada.
- Questões acadêmicas, Pastoral, onboarding detalhado, volume, desempenho, retenção e operações de escrita permanecem registradas como pendências das sprints correspondentes.
- Sprint 01 não iniciada. Mudanças necessárias poderão ser incorporadas nas sprints futuras, conforme orientação do usuário.
- O commit local desta sprint foi criado depois do aceite. Como era o primeiro commit, inclui a base versionável existente e os artefatos da Sprint 00. O resultado da publicação para origin/main está registrado em progresso.md.
