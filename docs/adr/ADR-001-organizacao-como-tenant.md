# ADR-001 — Organização como tenant

- Estado: decisão de princípio aceita pelo usuário
- Data: 14/10/2026

## Contexto

O SacraEdu é um SaaS escolar com várias organizações clientes. Cada escola poderá ter uma ou várias unidades. Uma organização não poderá enxergar nem saber que outra organização existe.

## Decisão

A organização escolar é o tenant. Suas unidades pertencem a essa organização e não são tenants independentes. O administrador da organização vê os dados da própria organização. O superadministrador, dono do sistema, tem acesso global explícito.

## Consequências

- Dados de clientes devem ser isolados por organização.
- Unidades devem ter vínculo com sua organização.
- A autorização do superadministrador é uma exceção global identificada e explícita; contexto ausente não concede acesso.
- Não se deve expor existência, identificadores ou dados de outra organização a usuários comuns de uma organização.

## Detalhes ainda pendentes

- Campos e identificadores de organização e unidade.
- Se e como usuários poderão ter vínculos com mais de uma organização.
- Operações administrativas disponíveis ao administrador da organização.
- Controles, procedimentos e eventos de auditoria para o superadministrador.
