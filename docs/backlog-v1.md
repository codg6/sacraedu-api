# Backlog inicial proposto

Ordem de descoberta, não compromisso de implementação nem substituto das sprints aprovadas. As prioridades poderão mudar após validar as pendências.

| Prioridade | Item | Base/status | Bloqueios ou saída esperada |
| --- | --- | --- | --- |
| P0 | Fechar organização como tenant, unidade subordinada e isolamento total entre organizações | Limite confirmado; regras restantes pendentes | Definir dados de organização/unidade e critérios negativos de autorização |
| P0 | Cadastro de organização e criação automática do administrador | Resultado confirmado | Definir ator, acesso/credenciais, verificação e falhas |
| P0 | Autorizar administrador por organização e superadministrador global | Limites de visibilidade confirmados | Definir operações e controles de acesso global; validar proposta de auditoria |
| P1 | Definir catálogo escolar e oferecer CRUD para todas as modalidades | Intenção de CRUD confirmada | Enumerar modalidades, etapas, entidades, campos, permissões e exclusões |
| P1 | Definir fluxos e regras acadêmicas | Ainda não definido | Matrícula, avaliação, frequência, fechamento e publicação |
| P2 | Definir registros, ativação e permissões da Pastoral opcional | Ainda não definido | Organização/unidade, conteúdo, acesso e retenção |
| P2 | Definir perfis posteriores e acesso de responsáveis, estudantes e profissionais | Expansão futura confirmada | Histórias e matriz por registro |
| P2 | Definir aceite funcional da v1, volume, desempenho e retenção | Ainda não definido | Exemplos mensuráveis e estimativas |
| P3 | Dashboard global de monitoramento e auditoria | Planejado para o futuro | Requisitos, eventos, acesso e retenção |
| Fora do escopo atual | Financeiro, cobrança SaaS, biblioteca, transporte e cantina | Não incluídos implicitamente | Aprovação explícita e planejamento de sprint, se necessários |

## Dependências

Não iniciar schema ou fluxos de negócio cujos dados, relações ou permissões estejam listados como pendentes. A Sprint 01 só pode começar após validar e aceitar o contrato da Sprint 00.
