# Arquitetura e estado inicial

Uma aplicação Spring Boot e PostgreSQL compartilhado, organizado por domínio. Nome técnico sacraedu-api; pacote base br.com.sacracod.sacraedu.

Decisão confirmada na Sprint 00: organização escolar é o tenant e poderá possuir uma ou várias unidades. Organizações clientes não podem descobrir umas às outras. O administrador de uma organização vê seus dados. O superadministrador do sistema é uma exceção global explícita. Os detalhes do cadastro, das permissões de escrita e da auditoria global continuam pendentes.

## Módulos planejados — proposta

| Módulo | Responsabilidade |
| --- | --- |
| app | Inicialização e composição |
| identidade | Contas e autenticação |
| organizacoes | Organizações, unidades e módulos ativos |
| acessos | Vínculos, papéis e permissões |
| pessoas | Alunos, responsáveis e profissionais |
| academico | Estrutura, turmas e matrículas |
| pedagogico | Frequência, notas e avaliações |
| pastoral | Atividades opcionais |
| auditoria | Operações relevantes |

O escopo funcional por módulo ainda está em validação; consultar mapa-modulos-v1.md. Módulos não compartilham livremente entidades/repositórios internos. Contratos explícitos e dependências sem ciclos. Transações locais; eventos somente quando houver necessidade. Dentro de cada domínio, criar api, aplicacao, dominio e infraestrutura conforme necessário, sem classes vazias.

## Persistência e execução

Local é perfil padrão; neon é explícito. Banco sacra_edu, container sacra-edu-postgres-local e volume sacra-edu-postgres-data preservados. Roles separadas para aplicação e migração. Configurações em src/main/resources, migrations em db/migration. Ao estruturar Maven multimódulo, mover os recursos ao módulo executável e atualizar caminhos sem duplicar o banco.

## Estado do código

O pom é uma base de aplicação única. Parent/poms filhos, classe principal, testes, endpoints, servidor emissor de tokens e controles tenant ainda não existem. Estruturá-los nas sprints apropriadas. Não confundir presença de dependência de segurança com autenticação implementada. Ver diretrizes.md para decisões detalhadas e gates. A Sprint 00 criou documentos de descoberta, mas permanece aberta até validar o contrato de escopo.
