# Diretrizes de desenvolvimento — SacraEdu

Referência: decisões da conversa em 14/10/2026. As regras fornecidas pelo usuário orientam a solução, com ajustes técnicos para correção e segurança. Este arquivo documenta decisões; não implementa os gates.

## Escopo atual

A v1 está em descoberta: inclui a intenção de CRUD para todas as modalidades de ensino, antes das regras de negócio, mas o catálogo e critérios ainda precisam ser validados. Pastoral será opcional; seu escopo permanece pendente. Não incluir frontend/mobile, outra API ou microsserviços sem decisão explícita. Comentários e explicações didáticas em português são obrigatórios.

## Arquitetura

Java 21, Spring Boot 3.5.x, Spring Data JPA, PostgreSQL local em Docker (Neon somente em testes cloud) e Maven. Uma aplicação executável, organizada por domínio. A meta acordada continua sendo Maven multimódulo: app compõe os módulos de negócio. O pom único desta entrega é uma base de dependências e deve ser reorganizado em parent/poms filhos na etapa de estruturação, antes de implementar domínios; não representa abandono da modularidade física acordada. Não criar tabelas ou classes vazias antecipadamente.

Compartilhamento de banco e tabelas por entidade, tenant_id obrigatório em dados do cliente. Decisão confirmada: tenant é a organização escolar, que possui uma ou várias unidades. Isolamento é distinto de organização do código. Cada administrador de organização fica limitado à própria organização; superadministrador global é exceção explícita e requer autorização global identificada. Operações e trilha de auditoria detalhadas para esse perfil permanecem pendentes. Lógica de negócio e limites @Transactional no Spring, integridade e execução transacional no PostgreSQL. Manter constraints e índices necessários, sem triggers ou stored procedures para regras de negócio.

## Isolamento e identidade

- Negação por padrão. Sem identidade e vínculo válido, não estabelecer contexto de organização para uma operação escolar. O superadministrador precisa de autorização global explícita; contexto ausente nunca representa acesso global.
- Nunca aceitar tenant arbitrário do request como prova de acesso.
- Contexto por requisição/transação; limpar em finally; tarefas assíncronas e jobs recebem contexto explícito validado e também limpam o contexto.
- Filtros Hibernate são defesa auxiliar. Toda operação deve ter escopo demonstrável: busca por ID, leitura, atualização, exclusão, insert, SQL nativo, bulk, cache e jobs.
- A entidade recebe tenant do contexto autorizado, não de DTO gravável livremente. Impedir alteração de tenant em atualizações.
- Cache futuro inclui tenant na chave. Não usar cache de dados compartilhados antes de definir isolamento.
- Preservar constraints compostas quando necessárias para impedir referência entre tenants e unicidade local.
- Exceções globais têm inventário explícito; não permitir que qualquer entidade simplesmente escolha não ter tenant.
- Usuários de uma organização não podem enumerar, consultar ou inferir a existência de outra. O papel global do superadministrador é uma exceção aprovada pelo usuário, não um atalho implícito de consulta.
- Registrar todos os acessos do superadministrador é uma proposta de controle que ainda requer validação de escopo, retenção e revisão. Nunca registrar senhas, tokens ou dados pessoais em logs.
- RLS não faz parte das configurações atuais. Reavaliar como defesa adicional antes da produção, com custo e compatibilidade do pooling medidos; não afirmar que filtro de ORM equivale a isolamento comprovado.
- Manter OAuth2/OIDC e JWT com componentes oficiais do Spring. Dependência Resource Server valida tokens; não é o servidor emissor. O servidor de autorização próprio entra na etapa de identidade. Não criar criptografia/protocolo próprios.
- Não incluir dados escolares sensíveis no JWT. Validar assinatura, issuer, audience, expiração e algoritmos permitidos; gerenciar chaves fora do código. JWT não substitui permissão por registro, vínculo ativo ou revogação.

## Persistência e Neon

- Somente migrations SQL manuais versionadas, ddl-auto=validate e sql.init.mode=never.
- Proibidas instruções de exclusão de tabela ou banco. Flyway clean desativado. Não alterar silenciosamente migrations já aplicadas.
- Role da aplicação sem DDL/superusuário e role de migração separada. Credenciais de migração presentes na configuração são para a fundação; antes da produção, executar Flyway em etapa controlada e retirar segredos DDL do processo permanente da API.
- Constraints não substituem permissões; permissões não substituem constraints.
- Índices compostos definidos a partir das consultas e medidos. UNIQUE composto pode atender à necessidade sem criar índice duplicado. Não forçar index scan indiscriminadamente.
- Pool máximo 4 por instância, com orçamento total considerando réplicas e migrações. Timeouts fornecidos são valores iniciais para medição, não garantia contra travamentos.
- Em produção, verificar certificado e hostname TLS com CA confiável; sslmode=require é exemplo de conexão criptografada, não prova de validação de identidade. Configurar verify-full no ambiente alvo e testar antes de dados reais.
- Transações curtas, sem chamadas externas prolongadas dentro da transação; retentativas apenas quando seguras e limitadas. Não repetir gravações cegamente após timeout.

## Gates do projeto

| Gate | Evidência | Bloqueio |
| --- | --- | --- |
| Requisito | Regra aprovada ou pendência explícita | Não inventar regra de negócio |
| Escopo | Alterações vinculadas à sprint | Não criar outra funcionalidade |
| Arquitetura | Teste de dependências entre módulos | Não permitir ciclos/acesso a internos |
| Isolamento | Testes com duas organizações/unidades e contexto ausente | Não liberar endpoint com caminho sem proteção |
| Segurança | Casos negativos de credenciais, tokens, privilégios e revogação | Falha impede aceite |
| Banco | Migração validada, privilégios mínimos, plano de índices | Sem alteração destrutiva/não versionada |
| Qualidade | Build, testes e migrações executados | Não declarar sucesso sem evidência |
| Revisão | Diff, pendências e demonstração didática | Próxima sprint só após aceite |

Implementar os gates automáticos com o repositório: CI, testes de arquitetura/integração e revisão das migrations. Branch protegida deverá exigir checks e revisão; o agente não deverá poder aprovar o próprio trabalho nem alterar proteções para passar. AGENTS.md orienta o agente, mas não é controle de acesso. Alterações em regras, CI, testes e critérios devem aparecer explicitamente no relatório e ser revisadas, nunca usadas para maquiar falhas.

## Desenvolvimento didático

Trabalhar por pequenas mudanças coerentes. Uma mudança pode exigir mais de um arquivo para compilar e funcionar: explicar quais arquivos precisam mudar juntos, em vez de deixar uma etapa quebrada por uma regra literal de arquivo único. Não fazer backend e frontend simultaneamente. Explicar antes, comentar motivos no código, demonstrar depois e registrar progresso.

## Situação desta entrega

A Sprint 00 atualizou os documentos de requisitos, glossário, histórias, matriz de permissões, mapa de módulos, backlog e propostas de ADR. A sprint continua aberta: há decisões materiais pendentes. Consulte progresso.md para distinguir artefatos preparados de implementação concluída. Nenhum código de produção foi implementado nesta sprint.

## Atualização — desenvolvimento local

PostgreSQL 17 local via Compose, volume fixo persistente e um banco de desenvolvimento. Neon somente com perfil explícito. Sem sincronização/duplicação de dados, sem seeds automáticos, sem limpeza sem solicitação ou aprovação específica. O script Docker provisiona roles/permissões apenas no volume vazio; tabelas de negócio continuam exclusivas de migrations Flyway. Consulte BANCO-LOCAL.md para comandos e limites da validação.

## Nome técnico do projeto

Pasta raiz, artifactId Maven raiz, name e spring.application.name: sacraedu-api. Pacote Java: br.com.sacracod.sacraedu. A mudança de nome não altera banco, container ou volume persistente.
