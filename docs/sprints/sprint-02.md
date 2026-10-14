# Sprint 02 — Organizações e isolamento de dados

Revisão 2 — 14/10/2026. Planejamento atualizado; não comprova conclusão da sprint.

## Objetivo e escopo

Implementar organização, unidade e configuração de módulos conforme Sprint 0. Definir dono de cada tabela, entidades globais e tenant_id nas entidades escolares. Implementar contexto de tenant validado, filtros e consultas restritas com negação por padrão. Proteger busca por ID, insert, update/delete, SQL nativo, bulk, cache e jobs; não confiar apenas no filtro Hibernate. Limpar contexto em finally e tratar execução assíncrona explicitamente. Usar roles de aplicação e migração separadas. Manter constraints compostas que impeçam referências entre tenants e índices orientados às consultas. Ainda não expor administração pública: usar fixtures de teste em banco temporário até Sprint 04. Não adicionar RLS nesta sprint; documentar a avaliação futura como defesa adicional.

## Dependência

Sprint 01 concluída.

## Critérios de aceite

Duas organizações fictícias isoladas em leitura/escrita/exclusão; tentativa de associação cruzada falha; contexto não vaza ao reutilizar conexão nem após rollback; acesso sem contexto falha; sem endpoint administrativo aberto.

## Aprendizado

Tenant, transação, contexto por requisição, filtros Hibernate e limites de isolamento.

## Prompt independente — copiar e executar

```text
Você está trabalhando no SacraEdu, SaaS escolar com foco em escolas católicas e módulo Pastoral opcional. Execute somente esta sprint. Leia primeiro AGENTS.md, README, decisões de arquitetura, modelo de dados e o estado das sprints que existirem no repositório. Se o repositório não estiver acessível, informe isso e não alegue implementação ou testes. Preserve alterações existentes.

Decisões: Java 21, Spring Boot 3.4+ (linha 3.5.x na fundação, verificar compatibilidade e suporte), PostgreSQL local em Docker; Neon apenas no perfil cloud, Maven multimódulo, monólito modular com uma aplicação executável. Segurança própria com Spring Security e servidor de autorização Spring, OAuth2/OIDC e JWT. Sem Keycloak ou provedor externo de identidade. Não criar microsserviços, segunda API de backup/exportação, frontend completo, filas ou infraestrutura distribuída sem necessidade demonstrada. BFF é uma decisão de integração web a documentar; não criar outro serviço agora. Organização e unidades são o modelo proposto, a validar na Sprint 0. Pastoral não pode ser dependência obrigatória do núcleo acadêmico.

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
Usar tenant_id obrigatório nas entidades de cliente e inventário explícito de exceções globais. Definir na Sprint 00 se tenant é organização/mantenedora ou escola; unidade não é necessariamente tenant. Contexto ThreadLocal validado a partir de vínculo autenticado, limpo em finally e tratado explicitamente em jobs/async. Filtros Hibernate são auxiliares: proteger também inserts, consultas por ID, SQL nativo, bulk, cache e gravações. Ausência de contexto nega acesso. Não implementar RLS automaticamente nesta versão; reavaliá-lo como defesa adicional antes da produção, com decisão documentada. A lógica de negócio e limites transacionais ficam no Spring, com integridade e atomicidade executadas pelo PostgreSQL.

Modo didático obrigatório: explique o problema antes da alteração; defina termos técnicos novos; comente em português decisões, regras e pontos de segurança, sem comentar trivialidades. Mostre um fluxo concreto, distinguindo o que o Spring faz do que implementamos. Inclua instruções de execução para Windows/PowerShell e alternativa Unix quando necessário. Use exemplos fictícios.

Qualidade: testes de regras e de autorização, integração com PostgreSQL real/Testcontainers quando aplicável, migrações Flyway e OpenAPI atualizado. Negar acesso por padrão, validar organização/unidade/registro, evitar entidades JPA expostas e segredos no código. Não invente regras escolares. Consulte documentação oficial para compatibilidade de versões e mecanismos de segurança e registre versões fixadas. Não enfraqueça controles para fazer testes passarem.

Trabalhe em incrementos pequenos nesta sprint. Prossiga em decisões técnicas reversíveis; pergunte apenas sobre ambiguidades materiais de negócio. Não implemente sprints futuras. No encerramento, entregue resumo, arquivos alterados, comandos executados e resultados reais, limitações, critérios de aceite atendidos e pendentes, explicação didática e exemplos de requisição sem segredos. Atualize docs/progresso.md e docs/sprints/ com evidências. Não declare conclusão se critérios falharem ou testes essenciais não puderem ser executados. Não publique nem altere produção.

SPRINT 02: Organizações e isolamento de dados
PRÉ-REQUISITOS: Sprint 01 concluída.

TRABALHO DESTA SPRINT:
Implementar organização, unidade e configuração de módulos conforme Sprint 0. Definir dono de cada tabela, entidades globais e tenant_id nas entidades escolares. Implementar contexto de tenant validado, filtros e consultas restritas com negação por padrão. Proteger busca por ID, insert, update/delete, SQL nativo, bulk, cache e jobs; não confiar apenas no filtro Hibernate. Limpar contexto em finally e tratar execução assíncrona explicitamente. Usar roles de aplicação e migração separadas. Manter constraints compostas que impeçam referências entre tenants e índices orientados às consultas. Ainda não expor administração pública: usar fixtures de teste em banco temporário até Sprint 04. Não adicionar RLS nesta sprint; documentar a avaliação futura como defesa adicional.

CRITÉRIOS DE ACEITE:
Duas organizações fictícias isoladas em leitura/escrita/exclusão; tentativa de associação cruzada falha; contexto não vaza ao reutilizar conexão nem após rollback; acesso sem contexto falha; sem endpoint administrativo aberto.

EXPLIQUE AO USUÁRIO:
Tenant, transação, contexto por requisição, filtros Hibernate e limites de isolamento.

Se os pré-requisitos não estiverem atendidos, identifique o que falta e não simule conclusão. Ao terminar, pare nesta sprint e deixe um resumo para a próxima sessão.
```
