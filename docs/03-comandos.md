# Docker Cheat Sheet 📚

Recomenda-se que esta página seja utilizada para consulta, trazendo ao leitor uma forma simples e direta de consultar comandos do `Docker CLI` que lhe podem ser úteis.

- Listando os containers ativos: `docker ps`

- Listando todos os containers - (Independente do status): `docker ps -a`

- Listando todas as imagens: `docker images`

- Executando um container: `docker run`

- Executando um container - (Com terminal interativo): `docker run -ti debian /bin/bash`

- Executando um container como daemon: `docker run -d`

- Saindo do *shell* de container sem finaliza-lo: CTRL + p + q

- Finalizando um container (Quando conectado em seu *shell*): CTRL + d

- Acessar o entrypoint de um container em execução: `docker attach CONTAINER_ID`

- Criando o container: `docker create centos`

- Parando um container: `docker stop CONTAINER_ID`

- Iniciando um container: `docker start CONTAINER_ID`

- Pausando um container: `docker pause CONTAINER_ID`

- Despausando um container: `docker unpause CONTAINER_ID`

- Verificando a quantidade de recursos utilizados pelo container: `docker stats CONTAINER_ID`

- Verificando os processos de um container: `docker top CONTAINER_ID`

- Visualizando os logs: `docker logs CONTAINER_ID`

- Removendo container desligado: `docker rm CONTAINER_ID`

- Removendo container em execução: `docker rm -f CONTAINER_ID`

- Verificando todas as informações de um container: `docker inspect CONTAINER_ID`

- Nomeando container no momento da execução: `docker run -ti --name teste debian`

- Verificando informações de memória de um container: `docker inspect CONTAINER_ID | grep -i mem`

- Limitando memória RAM na execução do container (512 MB neste caso): `docker run -ti --memory 512m --name limited_mem debian`

- Alterando quantidade de memória de um container já existente (256 MB neste caso): `docker update CONTAINER_ID --memory 256m`

- Limitando CPU de um container no momento da execução (Neste caso proporção de 1024): `docker run -ti --cpu-shares 1024 --name container1 debian`

- Alterando limite de CPU em container em execução (Neste caso proporção de 512): `docker update CONTAINER_ID --cpu-shares 512`

- Criando volume: `docker run -ti -v /volume /bin/bash`

- Mapeando volume: `docker run -ti -v /path/to/volume_dir:/volume debian`

- Verificando informações de volume: `docker inspect -f {{.Mounts}} CONTAINER_ID`

- Criando container data-only: `docker create -v /data --name dbDados centos`

- Criando container de banco de dados (Postgres) que utiliza o data-only: `docker run -d -p 5432:5432 --name pgsql1 --volumes-from dbdados -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql`

- Fazendo build de um Dockerfile que está no diretório atual: `docker build -t INSTITUICAO/NOME_DA_IMAGEM:VERSAO .`

- Definindo DNS do container na execução: `docker run -ti --dns ENDERECO_DNS debian`

- Criando link entre containers (Conexão entre *containers*): `docker run -ti --link container1 --name container2 debian`

- Abrindo porta do container na execução: `docker run -ti --expose PORTA debian`

- Definindo um MAC Address específico para um container na execução: `docker run -ti --mac-address 12:34:56:b0:6b:61 debian`

- Definindo a porta do container que será publicada: `docker run -d -p PORTA_HOST:PORTA_CONTAINER debian`
