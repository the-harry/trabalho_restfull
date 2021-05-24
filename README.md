# Trabalho RESTful

## Sobre

Essa API foi criada para explicar conceitos do protocolo HTTP e APIs REST. A ideia é que possamos manipular trabalhos com o protocolo HTTP.

## Subindo o projeto

Build do container e suba o projeto:

`docker-compose build && docker-compose up`

Ao subir o projeto acesse o container da api:

`docker-compose exec api bash`

Crie o banco:

`bin/setup`

Faça uma cópia do arquivo `db/alunos.json.sample` removendo o .sample do final, nele coloque o nome e número de matrícula dos alunos permitidos a enviar trabalhos.
Após isso rode o seed para popular o banco:

`rails db:seed`

## Conceitos basicos

### RECURSOS

Quando acessamos um link, buscamos por um recurso. Esse recurso pode ser uma página web, uma música, ou qualquer outro tipo de arquivo ou dado. Cada recurso é identificado por um URI(Uniform Resource Identifier), a URL que conhecemos, é um tipo de URI.
Quando trabalhamos com APIs temos sempre essa ideia de lidar com recursos, no nosso exemplo, os recursos são trabalhos, mas poderiam ser qualquer coisa.

[Mais informacoes sobre a estrutura de um recurso aqui](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web)

### ENDPOINTS

Um endpoint é o estágio final de uma URL, o caminho dentro do host onde o recurso está localizado. Exemplo:

`http://foobar:4242/path/to/resource/1`

Nesse caso mostrado acima temos o protocolo `http`, o host `foobar`, na porta `4242`, e o endpoint eh `/path/to/resource`, enquanto `1` é o identificador desse recurso.

Quando falamos de REST, queremos que nossos endpoints sejam semânticos,

### Versionamento de API

Uma boa prática quando construímos APIs REST é versionar nossa api, isolando os recursos dentro de namespaces específicos. O link acima poderia ser reescrito assim:

`http://foobar:4242/api/v1/path/to/resource/1`

Dessa maneira, quando atualizarmos nossa API não quebramos a compatibilidade com todos os serviços integrados nela, já que podemos manter a v1 e v2 funcionando em paralelo por um tempo até que todos migrem para a nova versão e a antiga seja descontinuada.

### Formatos de dados

Os dois principais formatos usados em APIs sao [JSON](https://www.json.org/json-en.html) e [XML](https://www.w3.org/XML/), o XML eh o mais antigo, ele trabalha com tags e eh mais dificil de trabalhar, o JSON é o formato mais recente e fácil de mexer que tem sido mais utilizado no lugar do XML, sempre dê preferência a usar JSON se possível.

O XML trabalha com a ideia de tags que são definidas pelo usuário:

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

~~falai, bem mais bonito, né? ;)~~

### VERBOS

Quando queremos exercer alguma ação sobre um recurso usamos verbos para indicar do que se trata essa ação. Abaixo estão os principais verbos:

* GET - Verbo usado para requisitar um recurso

* POST - Verbo usado para enviar/criar um recurso

* DELETE - Verbo usado para apagar um recurso

* PATCH - Verbo usado para editar apenas um atributo de um recurso

* PUT - Verbo usado para editar apenas um recurso inteiro

Sempre que for editar dê preferência ao PATCH por ser mais seguro que o POST, já que o ele atualiza todos atributos de um recurso ele pode acabar editando coisas que não deveriam.

Também temos outros métodos menos conhecidos, a seção 4.3 da rfc 7231 mostra todos os verbos com mais detalhes caso queira [dar uma olhada](https://tools.ietf.org/html/rfc7231#section-4.3).

### REQUEST

Um requerimento e uma solicitação a um recurso, ela é feita usando um verbo e um endpoint. Ela pode ou não ter parâmetros adicionais, esses parâmetros vão no `body` da requisição, e também temos os `headers` que como o nome diz são cabeçalhos com algumas informações sobre esse request, como por exemplo o formato que deve ser enviado(json/xml).


### CODIGOS HTTP

Quando fazemos uma requisição, o protocolo nos responde com um código informando o que está acontecendo. Esses códigos vão de 1 xx até 5xx.
Cada centena representa uma família de códigos:

* 1XX - Informativo

Os códigos da família 100 são pouco notados e conhecidos já que eles são códigos que ocorrem "por debaixo dos panos".
Alguns exemplos são os códigos:

- 100: Continuar

- 101: Mudando protocolo

* 2XX - Sucesso

A família do 200 representa alguns tipos de sucesso, por exemplo.

- 200: Ok (Ao acessar uma página qualquer por exemplo temos esse status)

- 201: Created (Ao criar um recurso novo, por exemplo enviar um trabalho :))

* 3XX - Redirecionamento

Assim como a família do 100, os códigos da família 300 também não são muito vistos, já que são códigos intermediários, muitas vezes acontecem alguns redirecionamentos até o request acabar, ou até mesmo um recurso não está mais disponível.
Alguns exemplos são:

- 301: moved

- 302: found

* 4XX - Erros do cliente

Essa deve ser a família mais conhecida dos códigos HTTP, ela indica erro do cliente, por exemplo quando você acessa uma página que não existe e recebe um 404.
Alguns exemplos dessa família são:

- 401: not authorized (quando alguem nao esta autenticado para fazer alguma ação)

- 404: not found (quando o recurso não é encontrado)

- 422: unprocessable entity (quando uma entidade não é processável geralmente os argumentos enviados nao sao validos.)

* 5XX - Erros do servidor

Esses são os erros que acontecem no backend, eles podem representar um erro interno do servidor ou algo externo a aplicação:

- 500: internal_server_error (Erro interno generico)

- 502: bad gateway (quando um servidor de origem enviou uma resposta inválida para outro servidor)

- 503: service unavailable (quando o servidor não está pronto para lidar com a requisição)

A lista com todos os codigos se encontram no capitulo 6 da [rfc7231](https://tools.ietf.org/html/rfc7231#section-6)

### AUTH

Algumas API são públicas e não precisamos nos autenticar, porém em APIs privadas precisamos nos autenticar para fazer as requisições. Quando falamos de autenticação temos diversas maneiras de fazer isso, entre elas:

- HTTP BASIC AUTH

- JWT

- SECRET KEY

- Oauth

- Oauth2

- CAS

Temos outros padrões mais e menos robustos, porém esses são os mais conhecidos. Sempre leia a documentação da API que você deseja usar para entender como se autenticar nela.

Caso queria entender um pouco mais sobre os tipos de autenticacao confira esse [link aqui](http://restcookbook.com/Basics/loggingin/).

### RATE LIMIT

Algumas APIs implementam o que é chamado de rate limit, isso que alguém envie muitas requisições para você em um curto espaço de tempo, isso pode acontecer por vários motivos, entre eles erro de algum programador enquanto testa a API, ou um atacante querendo derrubar o site. Já que cada request gasta um pouco de banda do seu servidor e bem, quando ela acabar seu site simplesmente vai parar de atender todos pedidos. ' ̄\_(ツ)_/ ̄'

Quando uma API implementar rate limit você provavelmente receberá um header informando um número de requests ainda disponíveis, geralmente esse limite é dado por minuto, ou seja, se você fez um request e recebeu o header `RateLimit: 9`, na janela de 1min você ainda pode fazer 9 requests. Mas essa janela de tempo pode variar dependendo como foi a implementação.

## Manipulando trabalhos na API

- AUTENTICACAO:

  Nesse projeto usamos uma autenticação simples usando um token representado por seu primeiro nome seguido de dois pontos e seu rm. Então lembre-se de colocar este header em todas as requisições.

  `Authorization: Token nome:rm`

- CRIAR TRABALHO:

  Primeiramente vamos criar um novo trabalho, aqui temos algumas opções de como enviar esse pedido, você pode usar algum programa com interface gráfica como o postman se sentir mais à vontade. Porém aqui nos exemplos usaremos o Curl, ele é conhecido por ser o canivete suico do protocolo HTTP.

  ```bash
  curl -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       -d '{"trabalho":{"title":"Algum trabalho","url":"localhost"}}' \
       http://localhost/api/v1/trabalho -v
  ```

  Antes de prosseguirmos nossa explicação vamos entender melhor o que esse comando está fazendo, quando enviamos um request com o curl, sempre que virmos uma flag `-H` significa que estamos passando um header para essa requisição, isso também pode ser escrito da maneira mais longa `--header`. O primeiro header que passamos indica que nossa solicitação será do tipo JSON, para que a aplicação saiba com o que está lidando, o segundo, nos autenticamos com o `nome:rm`.

  A flag `-d` é a forma curta para `--data`, quando passamos essa flag significa que estamos enviando dados em uma requisição, então por padrão o curl já muda o verbo do nosso pedido para um tipo POST.
  Quando não passamos essa flag normalmente ele tenta fazer um GET por padrão, existe também a flag `-X` para mudar o verbo de um request, mas no caso do exemplo acima o `-d` já infere que nosso request eh um POST e não precisamos usar o modificador `-X VERBO`.

  E observem a sintaxe para o corpo do request, ele se inicia em aspas simples, com o json dentro usando aspas duplas para cada chave e valor.

  As barras invertidas `\` são apenas para fazer a quebra de linha para o comando ficar mais legível.

  E por fim temos nossa URI e a flag `-v`, que significa que queremos que esse comando seja verboso, sem isso nós executaremos o comando e podemos não ter nenhum output, já que o linux tende a mostrar apenas erros, esse modo verboso nos mostra detalhes importantes sobre o request feito e sua resposta e código HTTP.

  Se tudo deu certo, o comando acima vai te retornar o status `201` informando que um trabalho foi criado, e um corpo informando o id do trabalho:

  '{"trabalho_id":1}'


- ENTENDENDO OS ERROS:

    Caso você faça algo errado a API vai tentar te indicar isso, por exemplo se você enviar um POST sem parâmetros:

    ```bash
    curl -H "Content-Type: application/json" \
         -H "Authorization: Token zezinho:666" \
         -d '{}' \
         http://localhost/api/v1/trabalho -v
    ```

    Nesse caso ele te retorna um código 422 com o seguinte corpo `{"error":"unprocessable_entity","message":"Missing params."}`.

- VER TRABALHOS ENVIADOS:

  Agora sim, entendemos como criar um projeto, vamos ver se conseguimos consultá-lo, nesse caso não queremos mais usar o verbo POST, já que não estamos enviando, e sim buscando informações. Para isso podemos indicar no endpoint da aplicação que queremos ver o trabalho OU, em uma API restful isso acaba virando um padrão de `recurso/:id`.

  ```bash
  curl -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       http://localhost/api/v1/trabalho/1 -v
  ```

  Observem que utilizei o ID recebido quando criei o trabalho. Você receberá um código 200 em caso de sucesso junto com as informações deste trabalho:

  `{"id":1,"title":"aula 1","url":"localhost","aluno_id":1,"created_at":"2020-08-09T13:45:16.347Z","updated_at":"2020-08-09T13:45:16.347Z"}`

  Caso você tente procurar um trabalho que não existe a API vai te retornar um 404:

  ```bash
  curl -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       http://localhost/api/v1/trabalho/42 -v
  ```

  '{"error":"not found","message":"Registro não encontrado."}`

  Outras duas coisas que podem acontecer é receber um 401 ou 403. Mesmo eles sendo parecidos significam coisas diferentes, podemos dizer que o 401 tem mais a ver com autenticação, enquanto o 403 com autorização, observem esses exemplos:

  ```bash
  curl -H "Content-Type: application/json" \
       http://localhost/api/v1/trabalho/1 -v
  ```

  Isso te retorna um 401 Unauthorized com a seguinte mensagem: `HTTP Token: Access denied`, ou seja, você não está autenticado.


  Porém imagine que a Luluzinha tente ver o trabalho do Zezinho, ela estaria autenticada, mas nao autorizada para ver esse recurso:

  ```bash
  curl -H "Content-Type: application/json" \
       -H "Authorization: Token luluzinha:999" \
       http://localhost/api/v1/trabalho/1 -v
  ```

  O que vai te retornar 403 Forbidden com o body: `{"message":"Nem pense nisso!"}`

- VER TODOS TRABALHOS:

  Como o rest implementa endpoints semânticos, quando queremos ver todos os trabalho usamos o endpoint `/api/v1/trabalhos`, que retornará todos os trabalhos, essa convenção de plural e singular indica se estamos lidando apenas com um recurso, ou uma coleção deles, então sempre preste atenção nesses detalhes.

  Primeiro vamos criar outro trabalho, apenas para ver a diferença em relação ao mostrar apenas um resultado.

  ```bash
  curl -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       -d '{"trabalho":{"title":"outro trabalho","url":"localhost"}}' \
       http://localhost/api/v1/trabalho -v
  ```

  Agora podemos ver todos nosso trabalhos com o seguinte request:

  ```bash
  curl -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       http://localhost/api/v1/trabalhos -v
  ```

  Isso vai te retornar um 200 OK e uma array com seus trabalhos:

  OBS: Ele não vai vir bonito assim, mas você pode copiar o json e [formata-lo](https://jsonformatter.curiousconcept.com) para ler melhor.

  ```json
  [
   {
      "id":1,
      "title":"primeiro trabalho",
      "url":"localhost",
      "aluno_id":1,
      "created_at":"2020-08-09T13:45:16.347Z",
      "updated_at":"2020-08-09T13:45:16.347Z"
   },
   {
      "id":2,
      "title":"outro trabalho",
      "url":"localhost",
      "aluno_id":1,
      "created_at":"2020-08-09T14:02:16.393Z",
      "updated_at":"2020-08-09T14:02:16.393Z"
   }
 ]
  ```

  Agora que vimos que temos dois trabalhos, vamos editar o primeiro para que seja o que vai de fato valer para a nota, e vamos apagar o outro.
  Mas antes de mais nada vamos falar sobre a diferença entre os verbos disponíveis para editar um recurso, temos o PUT e o PATCH:

- EDITAR COM PUT:

  ```bash
  curl -X PUT \
       -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       -d '{"title":"foobar"}' \
       http://localhost/api/v1/trabalho/2 -v
  ```

  Se formos ver ele atualizou corretamente o campo title, porém esse método é menos recomendado, já que ele nao eh tao seguro, observem a definição no site do mozilla:

  [The HTTP PUT request method creates a new resource or replaces a representation of the target resource with the request payload.](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PUT)

  Ou seja, ele atualiza o objeto completo, o que pode ser meio inseguro dependendo de como a API foi feita, pois você pode acabar apagando algum campo, isso não vai acontecer nessa API, fiquem tranquilos! ;)

- EDITAR COM PATCH

  Agora para editar parcialmente um recurso podemos usar o PATCH, sempre que possível dê preferência a esse verbo, a não ser que tenha um motivo para usar o PUT.

  Segundo a definição no site do mozilla:

  [The HTTP PATCH request method applies partial modifications to a resource.](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH)

  ```bash
  curl -X PATCH \
       -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       -d '{"url":"github.com/foo/bar"}' \
       http://localhost/api/v1/trabalho/2 -v
  ```

  Agora podemos conferir nosso recurso e validar que as alterações feitas foram persistidas de fato:

  ```bash
  curl -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       http://localhost/api/v1/trabalho/2 -v
  ```

  `{"id":2,"title":"foobar","url":"github.com/foo/bar","aluno_id":1,"created_at":"2020-08-09T14:02:16.393Z","updated_at":"2020-08-09T17:10:24.033Z"}`

- DELETE

  Finalmente, vamos destruir esse segundo registro usando o verbo DELETE:

  ```bash
  curl -X DELETE \
       -H "Content-Type: application/json" \
       -H "Authorization: Token zezinho:666" \
       http://localhost/api/v1/trabalho/2 -v
  ```

### Referências e recursos úteis

Temos algumas RFCs para especificações do protocolo HTTP, porém a 7231 define a semântica do protocolo. Vale a pena dar uma olhada caso queira mais detalhes.

[RFC 2616 - original](https://tools.ietf.org/html/rfc2616)

[RFC 7231 - atualiza a 2616](https://tools.ietf.org/html/rfc7231)

[Curl cheat sheet](https://devhints.io/curl)

[Rest Cookbook](http://restcookbook.com)

[Explicacao da mozilla sobre recursos](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Identifying_resources_on_the_Web)

[JSON](https://www.json.org/json-en.html)

[XML](https://www.w3.org/XML/)
