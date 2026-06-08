# Trabalho 03 - Linux, Shell Script e Cloud Computing

## Aluno
Matheus Ferrari dos Santos

## Tema
24 - Sistema de Gestão para um Pequeno Coworking

## Descrição do Projeto
Este projeto simula um ambiente operacional Linux para uma pequena aplicação de gestão de coworking. O cenário considera que um profissional júnior de DevOps precisa preparar uma instância Linux em container Docker, publicar um site estático no Apache e automatizar rotinas administrativas com Shell Script.

O sistema estático possui uma tela simples para cadastro local de reservas de salas. A aplicação serve como contexto para testar deploy, backup, monitoramento, processos, permissões e geração de relatórios.

## Tecnologias Utilizadas
- Linux Ubuntu 24.04
- Docker
- Docker Compose
- Apache
- Shell Script
- HTML, CSS e JavaScript
- GitHub
- DockerHub

## Estrutura do Projeto

```text
trabalho03-cloud-shell/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── scripts/
│   ├── 01_update.sh
│   ├── 02_apache.sh
│   ├── 03_estrutura.sh
│   ├── 04_backup.sh
│   ├── 05_deploy.sh
│   ├── 06_processos.sh
│   ├── 07_monitoramento.sh
│   ├── 08_usuarios_permissoes.sh
│   ├── 09_relatorio.sh
│   └── menu.sh
├── source/
│   ├── index.html
│   ├── sobre.html
│   └── assets/
├── backups/
├── logs/
└── evidencias/
```

## Como Executar o Projeto

Na pasta do projeto, execute:

```bash
docker compose up -d --build
```

Depois acesse o container:

```bash
docker exec -it trabalho03-linux-coworking bash
```

Dentro do container:

```bash
cd /app/scripts
chmod +x *.sh
./menu.sh
```

## Como Acessar o Apache no Navegador

Após subir o container, acesse:

```text
http://localhost:8080
```

## Scripts Disponíveis

| Script | Descrição |
|---|---|
| `01_update.sh` | Atualiza os pacotes do sistema com `apt update` e `apt upgrade -y` |
| `02_apache.sh` | Instala, valida e exibe a versão do Apache |
| `03_estrutura.sh` | Cria a estrutura temática do coworking em `/app/coworking` |
| `04_backup.sh` | Gera backup `.tar.gz` dos dados do coworking e da pasta `source` |
| `05_deploy.sh` | Publica os arquivos de `source/` em `/var/www/html` |
| `06_processos.sh` | Lista, busca e encerra processos por PID |
| `07_monitoramento.sh` | Monitora CPU, memória, disco e status do Apache |
| `08_usuarios_permissoes.sh` | Cria grupo, usuário de sistema e aplica permissões seguras |
| `09_relatorio.sh` | Gera relatório operacional em `/app/logs/relatorio_execucao.txt` |
| `menu.sh` | Menu interativo para executar as rotinas principais |

## Execução Individual dos Scripts

Dentro do container, execute:

```bash
cd /app/scripts
./01_update.sh
./02_apache.sh
./03_estrutura.sh
./04_backup.sh
./05_deploy.sh
./06_processos.sh listar
./06_processos.sh buscar apache
./07_monitoramento.sh
./08_usuarios_permissoes.sh
./09_relatorio.sh
```

Para testar o encerramento de processo com segurança:

```bash
./06_processos.sh matar <PID>
```

O script impede encerramento sem PID, PID inválido e PID 1.

## Diretórios Temáticos Criados

O script `03_estrutura.sh` cria os seguintes diretórios:

```text
/app/coworking/salas
/app/coworking/reservas
/app/coworking/membros
/app/coworking/contratos
/app/coworking/financeiro
/app/coworking/publicacao
/app/coworking/logs
/app/coworking/backups
```

Também são criados arquivos CSV simples para simular dados operacionais do coworking.

## Evidências de Funcionamento

As evidências devem ser geradas na máquina do aluno e salvas em `evidencias/`. Sugestões de prints:

1. `docker ps` mostrando o container em execução.
2. Conteúdo do `docker-compose.yml` mostrando volumes.
3. `ls -l scripts/` mostrando permissão de execução.
4. Execução de `./01_update.sh`.
5. Execução de `./02_apache.sh`.
6. Execução de `./03_estrutura.sh` e `find /app/coworking`.
7. Execução de `./04_backup.sh` e `ls -lh /app/backups`.
8. Execução de `./05_deploy.sh` e site aberto em `localhost:8080`.
9. Execução de `./07_monitoramento.sh`.
10. Execução de `./08_usuarios_permissoes.sh`.
11. Execução de `./09_relatorio.sh`.
12. Imagem publicada no DockerHub.

## DockerHub

Após testar o projeto, publique a imagem no DockerHub:

```bash
docker login
docker build -t seu-usuario/trabalho03-coworking:1.0 .
docker push seu-usuario/trabalho03-coworking:1.0
```

Link da imagem publicada:

```text
https://hub.docker.com/r/seu-usuario/trabalho03-coworking
```

Substitua `seu-usuario` pelo seu usuário real do DockerHub.

## Uso de IA

Foi utilizada IA como apoio para estruturação inicial dos scripts, documentação e organização do projeto. O conteúdo foi revisado e adaptado ao tema 24, Sistema de Gestão para um Pequeno Coworking, mantendo nomes de diretórios, usuários, grupos, logs, site e relatório relacionados ao cenário proposto.

## Principais Dificuldades Encontradas

- Adaptar comandos comuns de serviço, como Apache, para execução dentro de container Docker sem `systemd`.
- Garantir que os scripts criem logs e mensagens compreensíveis.
- Aplicar permissões seguras sem utilizar `chmod 777`.
- Organizar o projeto de forma que o professor consiga executar apenas seguindo o README.
