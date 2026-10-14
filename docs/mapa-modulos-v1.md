# Mapa inicial de módulos

Mapa de planejamento alinhado a arquitetura.md. Os nomes e limites técnicos são propostas. A tabela não aprova automaticamente todos os módulos para a v1.

| Módulo planejado | Responsabilidade considerada | Estado para a v1 |
| --- | --- | --- |
| app | Inicializar a aplicação e compor módulos. | Base técnica planejada |
| identidade | Contas, autenticação e ciclo de acesso inicial. | Necessário em princípio; cadastro do administrador pendente |
| organizacoes | Cadastro da organização tenant e de suas unidades. | Organização/unidade confirmadas; atributos e permissões pendentes |
| acessos | Vínculos, perfis e autorização por organização; perfil global do sistema. | Fronteiras confirmadas; catálogo detalhado de permissões pendente |
| pessoas | Dados de estudantes, responsáveis e profissionais. | Escopo e relacionamentos pendentes |
| academico | Modalidades e estrutura escolar; fluxos acadêmicos futuros. | CRUD de todas as modalidades confirmado em intenção; catálogo pendente |
| pedagogico | Avaliações, notas e frequência. | Regras de negócio adiadas e pendentes |
| pastoral | Funcionalidades opcionais. | Opcional confirmado; ativação e dados pendentes |
| auditoria | Registro de operações relevantes e suporte ao monitoramento global. | Futuro confirmado em intenção; eventos, acesso e retenção pendentes |

## Limites de arquitetura mantidos

Uma aplicação executável, monólito modular, PostgreSQL compartilhado e sem ciclos entre módulos. Nenhum módulo deve acessar livremente entidades ou repositórios internos de outro. Pastoral não será dependência do núcleo acadêmico. A lista deve ser refinada após o escopo funcional; não criar classes vazias para antecipar um módulo.
