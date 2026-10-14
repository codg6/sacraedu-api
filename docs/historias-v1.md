# Histórias e exemplos iniciais da v1

Rascunho de descoberta da Sprint 00. Exemplos ilustram o limite do requisito; não acrescentam regras acadêmicas.

## H-01 — Cadastro da organização e administrador

**Como** fluxo de cadastro de uma organização, **quero** que o sistema crie automaticamente um usuário administrador para ela, **para** que haja um primeiro usuário com acesso à organização.

**Exemplo:** ao cadastrar a organização fictícia Colégio Exemplo, o sistema cria um administrador vinculado a ela.

**Confirmado:** a criação automática do usuário administrador. **Pendente:** quem inicia o cadastro, como a conta recebe credenciais/acesso, verificações exigidas e tratamento de falhas ou duplicidade.

## H-02 — Visibilidade dentro da organização

**Como** administrador de uma organização, **quero** ver todos os dados da minha organização, **para** acompanhar suas unidades e seus dados escolares.

**Exemplo:** se o Colégio Exemplo tiver as unidades Centro e Norte, o administrador vê dados das duas.

**Confirmado:** visibilidade dentro da própria organização. **Pendente:** catálogo de registros, operações de escrita e regras para conceder outros acessos.

## H-03 — Isolamento entre organizações

**Como** usuário de uma organização, **quero** que outra organização não apareça para mim, **para** preservar a separação entre clientes do SaaS.

**Exemplo:** um usuário do Colégio Exemplo não consegue consultar nem enumerar a Escola Modelo.

**Confirmado:** uma organização não deve ver nem saber que outra existe. A implementação deverá cobrir consultas, IDs diretos, gravações e demais caminhos de acesso.

## H-04 — Acesso global do superadministrador

**Como** dono do sistema, **quero** ter acesso a todas as organizações e ao sistema, **para** administrar o serviço.

**Confirmado:** acesso global. **Futuro confirmado:** dashboard de monitoramento e auditorias. **Pendente:** operações administrativas, eventos auditados, retenção e requisitos de revisão.

## H-05 — CRUD das modalidades

**Como** usuário com perfil autorizado, **quero** cadastrar, consultar, atualizar e excluir os registros das modalidades de ensino incluídas, **para** administrar os cadastros iniciais.

**Confirmado:** a intenção de oferecer CRUD para todas as modalidades antes das regras de negócio. **Pendente:** lista de modalidades, entidades e campos, perfil autorizado, política de exclusão e critérios de aceite.

## Fora dos critérios por enquanto

Não há histórias aprovadas para matrícula, notas, frequência, acesso de responsáveis ou estudantes, Pastoral, financeiro, biblioteca, transporte ou cantina. Esses fluxos aguardam requisitos próprios.
