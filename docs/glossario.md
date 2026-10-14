# Glossário inicial

Termos registrados a partir das decisões confirmadas em 14/10/2026. Os termos marcados como pendentes não definem regras de produto.

| Termo | Significado atual | Situação |
| --- | --- | --- |
| SacraEdu | Produto SaaS de gestão escolar para escolas católicas e outras escolas. | Confirmado |
| Organização | Escola cliente do SaaS; limite de isolamento entre clientes. | Confirmado |
| Tenant | Limite lógico de dados e acesso de um cliente. No SacraEdu, corresponde à organização. | Confirmado |
| Unidade | Unidade pertencente a uma organização. A organização poderá ter uma ou várias. | Confirmado; campos e relações acadêmicas pendentes |
| Administrador da organização | Usuário criado automaticamente no cadastro da organização e autorizado a ver os dados daquela organização. | Confirmado; onboarding e permissões de escrita pendentes |
| Superadministrador | Dono do sistema, com acesso global às organizações e ao sistema. | Confirmado; operações, trilha de auditoria e controles detalhados pendentes |
| Modalidade de ensino | Termo usado pelo usuário para a cobertura de CRUD inicial. As categorias exatas e seu modelo ainda serão definidos. | Pendente de detalhamento |
| CRUD | Criar, consultar, atualizar e excluir registros. A política de exclusão e a lista de registros para cada fluxo ainda não foram especificadas. | Expansão confirmada; detalhes pendentes |
| Pastoral | Componente opcional do produto. Conteúdo, ativação e acesso ainda não definidos. | Opcional confirmado; escopo pendente |

## Exemplo apenas ilustrativo

“Colégio Exemplo” pode ser uma organização com as unidades Centro e Norte. O administrador dessa organização vê os dados do Colégio Exemplo. Ele não pode saber que existe “Escola Modelo”, que pertence a outra organização. O superadministrador do sistema tem acesso global. Os nomes e a quantidade de unidades deste exemplo não são requisitos.
