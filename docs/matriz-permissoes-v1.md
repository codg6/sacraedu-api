# Matriz inicial de permissões

Rascunho para validação. “Pendente” significa que não há decisão suficiente para implementar a permissão.

| Ação/escopo | Administrador da organização | Superadministrador | Outros perfis |
| --- | --- | --- | --- |
| Ver todos os dados da própria organização | Confirmado | Confirmado | Pendente |
| Ver dados de outra organização | Negado | Acesso global confirmado | Pendente |
| Descobrir a existência de outra organização | Negado | Acesso global confirmado | Pendente |
| Ver dados de todas as unidades da organização | Confirmado pelo escopo da organização | Acesso global confirmado | Pendente |
| Criar ou alterar organização/unidade | Pendente | Acesso global a todo o sistema confirmado; controles operacionais pendentes | Pendente |
| Cadastrar e operar o CRUD de modalidades | Administrador é a proposta inicial; confirmar | Acesso global a todo o sistema confirmado; controles operacionais pendentes | Pendente |
| Criar outros usuários/perfis | Pendente | Acesso global a todo o sistema confirmado; fluxo detalhado pendente | Perfis ainda não definidos |
| Acessar dados de estudantes, responsáveis e professores | Pendente por categoria de dado | Acesso global a todo o sistema confirmado; auditoria e procedimentos pendentes | Pendente |
| Acessar dados pastorais | Pendente | Acesso global a todo o sistema confirmado; conteúdo da Pastoral pendente | Pendente |
| Monitorar e auditar o sistema por dashboard | Não faz parte do escopo confirmado desse perfil | Previsto para o futuro | Pendente |

## Regras de leitura

- Administradores de organização recebem escopo de uma organização. A requisição não poderá escolher livremente um tenant.
- O superadministrador é a exceção global explicitamente confirmada, inclusive para escrita. O acesso global deverá ser representado por identidade e autorização explícitas, não por ausência acidental de contexto.
- A proposta de registrar e auditar todos os acessos globais precisa de validação. Dados pessoais, senhas e tokens não podem ser gravados em logs.
- Esta matriz não concede permissões a responsáveis, estudantes, professores ou outros perfis ainda não definidos.
