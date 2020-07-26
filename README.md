# Trabalho RESTful

## Sobre

Essa API foi criada para explicar conceitos do protocolo HTTP e APIs REST. A ideia eh que possamos manipular trabalhos com o protocolo HTTP.

## Subindo o projeto

Build do container e suba o projeto:

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

Quando acessamos um link, buscamos por um recurso. Esse recurso pode ser uma pagina web, uma musica, ou qualquer outro tipo de arquivo ou dado. Cada recurso eh identificado por um URI(Uniform Resource Identifier), a URL que conhecemos, eh um tipo de URI.
Quando trabalhamos com APIs temos sempre essa ideia de lidar com recursos, no nosso exemplo, os recursos serao trabalhos, mas poderiam ser qualquer coisa.

[Mais informacoes sobre a estrutura de um recurso aqui](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web)

### ENDPOINTS

Um endpoint eh o estagio final de uma URL, o caminho dentro do host aonde o recuso esta localizado. Exemplo:

`http://foobar:4242/path/to/resource/1`

Nesse caso mostrado acima temos o protocolo `http`, o host `foobar`, na porta `4242`, e o endpoint eh `/path/to/resource`, enquanto `1` eh o identificador desse recurso.

### Versionamento de API

Uma boa pratica quando construimos APIs REST eh versionar nossa api, isolando os recursos dentro de namespaces especificos. O link acima poderia ser reescrito assim:

`http://foobar:4242/api/v1/path/to/resource/1`

Dessa maneira quando atualizarmos nossa API nao quebramos a compatibilidade com todos os servicos integrados nela, ja que podemos manter a v1 e v2 funcionando em paralelo por um tempo ate que todos migrem para a nova versao e a antiga seja descontinuada.

### Formatos de dados

Os dois principais formatos usados em APIs sao [JSON](https://www.json.org/json-en.html) e [XML](https://www.w3.org/XML/), o XML eh o mais antigo, ele trabalha com tags e eh mais dificil de trabalhar, o JSON eh o formato mais recente e facil de mexer que tem sido mais utilizado no lugar do XML, sempre de preferencia a usar JSON se possivel.

O XML trabalha com a ideia de tags que sao definidas pelo usuario:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<root>
   <element>
      <nome>Chafundifórnio</nome>
      <amigo_de>Espiriquidiberto</amigo_de>
   </element>
</root>
```

Enquanto o JSON trabalha com objetos de javascript:

```json
[
  {
    "nome": "Chafundifórnio",
    "amigo_de": "Espiriquidiberto"
  }
]
```

~~falai, bem mais bonito, ne? ;)~~

### VERBOS

Quando queremos exercer alguma acao sobre um recurso usamos verbos para indicar do que se trata essa acao. Abaixo estao os principais verbos:

* GET - Verbo usado para requisitar um recurso

* POST - Verbo usado para enviar/criar um recurso

* DELETE - Verbo usado para apagar um recurso

* PATCH - Verbo usado para editar apenas um atributo de um recurso

* PUT - Verbo usado para editar apenas um recurso inteiro

Sempre que for editar de preferencia ao PATCH por ser mais seguro que o PUT, ja que o ele atualiza todos atributos de um recurso ele pode acabar editando coisas que nao deveriam.

Tambem temos outros metodos menos conhecidos, a secao 4.3 da rfc7231 mostra todos os verbos com mais detalhes caso queira [dar uma olhada](https://tools.ietf.org/html/rfc7231#section-4.3).

### REQUEST

Um request eh uma solicitacao a um recurso, ela eh feita usando um verbo e um endpoint. Ela pode ou nao ter parametros adicionais, esses parametros vao no `body` da requisição, e tambem temos os `headers` que como o nome diz sao cabecalios com algumas informacoes sobre esse request, como por exemplo o formato que deve ser enviado(json/xml).


### CODIGOS HTTP

Quando fazemos uma requsicao, o protocolo nos responde com um codigo informando o que esta acontecendo. Esses codigos vao de 1xx ate 5xx.
Cada centena representa uma familia de codigos:

* 1XX - Informativo

Os codigos da familia 100 sao pouco notados e conhecidos ja que eles sao codigos que ocorrem "por debaixo dos panos".
Alguns exemplos sao os codigos:

- 100: Continuar

- 101: Mudando protocolo

* 2XX - Sucesso

A familia do 200 representa alguns tipos de sucesso, por exemplo.

- 200: Ok (Ao acessar uma pagina qualquer por exemplo temos esse status)

- 201: Created (Ao criar um recurso novo, por exemplo enviar um trabalho :))

* 3XX - Redirecionamento

Assim como a familia do 100, os codigos da familia 300 tambem nao sao muito vistos, ja que sao codigos intermediarios, muitas vezes acontecem alguns redirecionamentos ate o request acabar, ou ate mesmo um recurso nao estar mais disponivel.
Alguns exemplos sao:

- 301: moved

- 302: found

* 4XX - Erros do cliente

Essa deve ser a familia mais conhecida dos codigos HTTP, ela indica erro do cliente, por exemplo quando voce acessa uma pagina que nao existe e recebe um 404.
Alguns exemplos dessa familia sao:

- 401: not authorized (quando alguem nao esta autenticado para fazer alguma acao)

- 404: not found (quando o recurso nao eh encontrado)

- 422: unprocessable entitie (quando uma entidade nao eh processavel geralmente os argumentos enviados nao sao validos.)

* 5XX - Erros do servidor

Esses sao os erros que acontecem no backend, eles podem representar um erro interno do servidor ou algo externo a aplicacao:

- 500: internal_server_error (Erro interno generico)

- 502: bad_gateway (quando um servidor de origem enviou uma resposta inválida para outro servidor)

- 503: service_unavailable (quando o servidor não está pronto para lidar com a requisição)

A lista com todos os codigos se encontram no capitulo 6 da [rfc7231](https://tools.ietf.org/html/rfc7231#section-6)

### AUTH

Algumas API sao publicas e nao precisamos nos autenticar, porem em APIs privadas precisamos nos autenticar para fazer as requisicoes. Quando falamos de autenticacao temos diversas maneiras de fazer isso, entre elas:

- HTTP BASIC AUTH: Eh enviado um cabecalio

- JWT

- SECRET KEY

- Oauth

- Oauth2

- CAS

Temos outros padroes mais e menos robustos, porem esses sao os mais conhecidos. Sempre leia a documentacao da API que voce deseja usar para entender como se autenticar nela.

### RATE LIMIT

Algumas APIs implementam o que eh chamado de rate limit, isso que alguem envie muitas requisicoes para voce em um curto espaco de tempo, isso pode acontecer por varios motivos, entre eles erro de algum programador enquanto testa a API, ou um atacante querendo derrubar o site. Ja que cada request gasta um pouco de banda do seu servidor e bem, quando ela acabar seu site simplesmente vai parar de atender todos requests. `¯\_(ツ)_/¯`

Quando uma API implementar rate limit voce provavelmente rebera um header informando um numero de requests ainda disponiveis, geralmente esse limite eh dado por minuto, ou seja, se voce fez um request e recebeu o header `RateLimit: 9`, na janela de 1min voce ainda pode fazer 9 requests. Mas essa janela de tempo pode variar dependendo como foi a implementacao.

## Manipuplando trabalhos na API

- expolicar auth

- criar trabalho

- ver

- criar outro e ver todos

- editar com put

- editar com patch

- destroy

### Referências e recursos úteis

Temos algumas RFCs para especificacoes do protocolo HTTP, porem a 7231 define a semantica do protocolo. Vale a pena dar uma olhada caso queira mais detalhes.
!!! image

[RFC 2616 - original](https://tools.ietf.org/html/rfc2616)
[RFC 7231 - atualiza a 2616](https://tools.ietf.org/html/rfc7231)
[Curl cheat sheet](https://devhints.io/curl)
[Rest Cookbook](http://restcookbook.com)
[Explicacao da mozilla sobre recursos](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web)
[JSON](https://www.json.org/json-en.html)
[XML](https://www.w3.org/XML/)
