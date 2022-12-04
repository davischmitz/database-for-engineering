## Gerenciamento de cadastros de usuários e produtos para uma loja
Aplicação a ser acoplada a um site de vendas.

## How to install:
  - *pipenv install* 

## How to run:
  - Navigate to the `store/src/api` folder 
  - *uvicorn app.main:app --reload* 

## Endpoints
- /docs
- /users
- /products
- <del> /orders <del>
- <del> /cart <del>

## Interface
- Acessar endpoint /docs ou Postman

obs.: endpoints de carrinho e pedido foram mantidos no projeto mas retirados do mapeamento da aplicação pois o foco da aplicação mudou.

## Funcionalidades:

- Gerenciamento de cadastro
- Gerenciamento de produto

- View:
Calculo de volume do produto

- Trigger:
Atualizar histórico do usuário

## Database
- postgreSQL versão 15.1
- Para rodar um container com o postgres (sistema gerenciador de banco de dados objeto relacional), rodar o comando 'docker compose up' no diretório src do projeto
- Manipulações com o banco podem ser feitas utilizando o dbeaver

## References:
- https://fastapi.tiangolo.com/
- https://github.com/kirillzhosul/api
