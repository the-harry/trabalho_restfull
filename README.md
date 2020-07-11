# Trabalho RESTful

## Sobre

Essa API foi criada para explicar conceitos do protocolo HTTP e APIs REST. A ideia eh que possamos manipular trabalhos com o protocolo HTTP.

## Subindo o projeto

Build do container e subir o projeto:

`docker-compose build && docker-compose up`

Ao subir o projeto acesse o container da api:

`docker-compose exec api bash`

Crie o banco:

`bin/setup`

Faca uma copia do arquivo `db/alunos.json.sample` removendo o .sample do final, nele coloque o nome e numero de matricula dos alunos permitidos a enviar trabalhos.
Apos isso rode o seed para popular o banco:

`rails db:seed`

## Conceitos basicos

### RECURSOS


### ENDPOINTS

### CODIGOS HTTP

### AUTH

### VERBOS


### Outros recursos interessantes

Temos algumas RFCs para especificacoes do protocolo HTTP, porem a 7231 define a semantica do protocolo. Vale a pena dar uma olhada caso queira mais detalhes.
!!! image

[RFC 7231](https://tools.ietf.org/html/rfc7231)
[Curl cheat sheet](https://devhints.io/curl)
