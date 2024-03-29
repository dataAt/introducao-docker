# Exemplos de uso

Este capítulo apresenta exemplos de utilização do Docker para a configuração e utilização de diferentes ferramentas. As imagens utilizadas serão recuperadas do Dockerhub. Boa parte dessas imagens oficiais, ou seja, distribuídas pelo grupo, organização ou instituição que cria a ferramenta.

> Aproveite os exemplos para ver o quão simples é o compartilhamento de imagens via registry e também, o quão simples é implantar diferentes serviços com o Docker. Não é necessário diversos arquivos de configuração!

Não deixe de conferir a página de cada imagem no Dockerhub para verificar todas as opções disponíveis.

## Postgres

[![saythanks](res/say-thanks-ff69b4.svg)](https://hub.docker.com/_/postgres)

Vamos criar um *container* que possui um banco de dados Postgres e faça a disponibilização desse para uso.

Para começar vamos utilizar o comando `docker pull`, que baixa a imagem do registry, neste caso, do Dockerhub e salva em sua lista de imagens.

```
docker pull postgres # Imagem oficial
```

A imagem já está em sua máquina, agora vamos iniciar o serviço

```
docker run --name postgresbd -e POSTGRES_PASSWORD=123@abc -p 5432:5432 -d postgres
```

> O parâmetro `-e` é utilizado para definir variáveis de ambiente e o `-p` para definir o direcionamento de porta a ser feito, neste caso, o *container* recebe na porta 5432 e encaminha para a porta 5432 do serviço que está sendo executado.

Pronto! O serviço do banco de dados já está sendo executado, você pode consultar o *container* executando através do comando `docker ps`.

> Para se conectar ao banco você pode utilizar as seguintes informações
```
Endereço: 127.0.0.1
Porta: 5432
Usuário: postgres
Senha: 123@abc
```

A imagem utilizada neste exemplo é oficial.

## Postgres + PostGIS

[![saythanks](res/say-thanks-ff69b4.svg)](https://hub.docker.com/r/kartoza/postgis/)

O Postgres possui uma extensão para trabalhar dados geoespaciais, com o Docker a utilização deste é muito simples. Através de uma imagem disponibilizada por um usuário do Dockerhub, todas as configurações deste serviço já são feitas. Vejamos como utiliza-lo.

Vamos baixar a imagem

```
docker pull kartoza/postgis
```

Após baixar a imagem, basta inicializar o *container* da imagem baixada.

```
docker run --name postgis -p 25432:5432 -d -t kartoza/postgis
```

## pgAdmin

[![saythanks](res/say-thanks-ff69b4.svg)](https://hub.docker.com/r/dpage/pgadmin4/)

Para acessar os serviços de bancos de dados criados anteriormente, pode-se utilizar um *container* com um pgAdmin.

Vamos começar baixado a versão mais recente desta imagem, para isto, no momento do *download* a `TAG` que normalmente indica a versão será passada.

```shell
docker pull dpage/pgadmin4:latest
```

Agora, vamos executar

```
docker run -p 8080:80 \
        -e "PGADMIN_DEFAULT_EMAIL=email@email.com" \
        -e "PGADMIN_DEFAULT_PASSWORD=1234." \
        -d dpage/pgadmin4:latest
```

Pronto! Agora se você acessar [127.0.0.1:8080](http://127.0.0.1:8080)

> Para entrar, utilize as credenciais definidas nas variáveis de ambiente no momento que o *container* foi criada.

## Aplicação

Nesta subseção, vamos inserir uma aplicação Python e Flask dentro de um *container*. Para isto, inicialmente façamos a criação do arquivo `app.py`, neste o conteúdo abaixo é inserido.

```python
from flask import Flask, escape, request

app = Flask(__name__)

@app.route('/')
def ola_no_container():
    nome = request.args.get("nome")
    return f"Olá, {escape(nome)}! Estou dentro de um container!"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
```

É possível perceber na listagem de código acima que esta aplicação básicamente inicia um servidor através do Flask e este recebe requisições HTTP que podem conter um parâmetro `nome` na requisição, e o conteúdo dessa parâmetro passado pelo usuário é exibido no retorno do servidor.

Bem, agora façamos a criação de um `Dockerfile`. Vamos utilizar o *container* oficial de Python em sua versão 3. Neste `Dockerfile` especificamos também que um comando `RUN` deve ser executado, para executar o pip para instalar o Flask, além de copiar o arquivo `app.py` para dentro do *container*.

Por fim é especificado que o `ENTRYPOINT`, ou seja, o comando principal do *container* será o `python` e ele recebe como parâmetro o nome do arquivo que ele executa (`app.py`).

```shell
FROM python:3

# O container, no momento da execução, 'escuta' a porta 5000
EXPOSE 5000

COPY app.py ./

RUN pip install Flask

# Argumentos para o entrypoint
CMD [ "./app.py" ]

ENTRYPOINT [ "python" ]
```

Agora execute o `docker build` para criar a imagem.

```shell
# Build
docker build -t "flaskapp:0.1" .
```

Com a imagem criada, vamos iniciar o *container*.

```
# Execução
docker run -d -p 5000:5000 flaskapp:0.1
```

Agora sim! Vá até seu navegador e acesse o endereço [127.0.0.1:5000](http://127.0.0.1:5000?nome=seunome)

> Você pode editar a URL de requisição e inserir seu nome, por exemplo: http://127.0.0.1:5000?nome=Julia
