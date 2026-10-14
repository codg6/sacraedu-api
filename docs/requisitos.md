# Requisitos e decisões

Atualizado em 14/10/2026. Este documento separa decisões confirmadas pelo usuário, propostas de trabalho e questões em aberto. Um item proposto não autoriza implementação.

## Confirmado pelo usuário

- O produto SacraEdu será um SaaS escolar para escolas católicas e outras escolas. A Pastoral será opcional.
- A organização representa uma escola e é o tenant. Uma organização poderá ter uma ou várias unidades.
- Uma organização não poderá consultar nem descobrir a existência de outra organização.
- No cadastro de uma organização será criado automaticamente um usuário administrador daquela organização. Esse administrador poderá ver todos os dados da própria organização.
- Haverá um superadministrador, dono do sistema, com acesso a todas as organizações e a todo o sistema. Um dashboard para monitoramento e auditorias é previsto para o futuro.
- Inicialmente haverá o administrador da organização e o superadministrador. Os demais perfis serão definidos e acrescentados em sprints futuras.
- A primeira etapa deverá oferecer CRUD para todas as modalidades de ensino. As regras de negócio acadêmicas serão implementadas depois. A lista de modalidades e o conteúdo exato desse CRUD ainda precisam ser detalhados.
- Regras de matrícula, notas, frequência e outras políticas acadêmicas permanecem indefinidas.
- O escopo, os dados e a ativação da Pastoral permanecem indefinidos.

## Direção técnica já registrada

- Nome técnico sacraedu-api; Java 21; Spring Boot, linha 3.5.x na fundação; Maven multimódulo; monólito modular com uma aplicação executável.
- Antes de implementar, verificar suporte e compatibilidade da versão Spring Boot fixada na fundação. BFF é integração web futura a avaliar; não criar outro serviço agora.
- PostgreSQL local em Docker é o padrão; Neon só será usado para teste cloud solicitado explicitamente.
- Autenticação e autorização próprias, usando componentes oficiais do Spring, OAuth2/OIDC e JWT. Sem Keycloak, provedor externo de identidade ou criptografia própria.
- Tabelas de dados escolares compartilhadas levam tenant_id obrigatório, salvo exceções globais documentadas. A organização fornece o limite do tenant; unidades pertencem a uma organização.
- Flyway com migrations SQL manuais; Hibernate em validate; limpeza automática e seeds duplicadores são proibidos.
- Preservar o banco sacra_edu, o container sacra-edu-postgres-local e o volume sacra-edu-postgres-data. Nunca gerar DROP TABLE ou DROP DATABASE.
- Não incluir agora segunda API, microsserviços, frontend completo ou mobile.

## Propostas para validação

- A matriz de permissões em matriz-permissoes-v1.md sugere as fronteiras entre os administradores e deixa poderes de escrita não especificados como pendentes.
- O mapa em mapa-modulos-v1.md é uma decomposição inicial; não aprova por si só todo módulo para a v1.
- A ordem em backlog-v1.md é uma proposta para planejar as sprints seguintes.
- Registrar e auditar cada acesso global do superadministrador é uma proposta de segurança. A abrangência e a retenção desses registros ainda não foram aprovadas.

O superadministrador é a exceção global explícita à separação entre organizações. Essa permissão ampla não se estende aos usuários comuns de uma organização.

## Pendências que afetam modelagem ou aceite

1. **Cadastro e acesso inicial:** quem pode cadastrar uma organização; como a conta do administrador automático recebe acesso; quais operações de escrita esse administrador terá.
2. **Unidades e catálogo acadêmico:** quais dados descrevem organização e unidade; o que significa modalidade no produto; quais modalidades e etapas escolares precisam de CRUD na primeira entrega.
3. **Perfis e autorização:** permissões de escrita detalhadas do administrador da organização; credenciais e controles operacionais para o acesso global; usuários, responsáveis, professores e estudantes ficam para definição posterior.
4. **Fluxos acadêmicos:** estados de matrícula, vagas, transferências, cancelamentos, avaliações, pesos, médias, recuperação, frequência, fechamento e publicação.
5. **Pastoral:** ativação por organização ou unidade, categorias de dados permitidos, perfis com acesso, retenção e relação com o núcleo acadêmico.
6. **Critério de v1:** fluxos obrigatórios, exemplos de aceite, integrações incluídas e condições para considerar a primeira versão completa.
7. **Operação:** estimativas de organizações, unidades, estudantes e concorrência; metas de resposta, retenção e auditoria.
8. **Exclusões:** financeiro, cobrança SaaS, biblioteca, transporte e cantina não estão incluídos implicitamente. Decidir depois se algum merece sprint própria.

## Regra de avanço

Itens que determinam entidades, relações ou autorização precisam ser respondidos antes de implementar os fluxos correspondentes. Itens ainda sem resposta permanecem pendentes e não podem ser preenchidos com suposições. A Sprint 00 continua aberta até o usuário validar o contrato documental; os detalhes explicitamente adiados ficam registrados como bloqueios das implementações correspondentes.
