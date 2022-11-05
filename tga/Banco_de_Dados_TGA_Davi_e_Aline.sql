-- PostgreSQL 9.6
-- Definições:
-- - vendedores precisam ser pessoas físicas, com CPF
-- - vendedor e comprador podem ter mais de um endereço
-- - pode ocorrer um cenário em que o vendedor e o comprador são o mesmo usuário
CREATE TABLE Produto (
  id uuid default uuid_generate_v4(),
  fabricacao_timestamp DATE,
  custo_unitario DECIMAL,
  nome char (50),
  altura DECIMAL,
  comprimento DECIMAL,
  largura DECIMAL,
  massa DECIMAL,
  codigo_barra char (30),
  estoque INTEGER,
  PRIMARY KEY (id)
);

CREATE TABLE Usuario (
  cpf CHAR (11),
  nome char (10),
  sobrenome char (30),
  email char (30),
  telefone char (9),
  PRIMARY KEY (cpf)
);

CREATE TABLE Comprador (
  id uuid default uuid_generate_v4(),
  cartao char (16),
  cpf_usuario char (11),
  FOREIGN KEY (cpf_usuario) references Usuario(cpf),
  PRIMARY KEY (id)
);

CREATE TABLE Vendedor (
  id uuid default uuid_generate_v4(),
  registro char (20),
  cpf_usuario char (11),
  PRIMARY KEY (id),
  FOREIGN KEY (cpf_usuario) references Usuario(cpf)
);

-- ao excluir um Pedido, todos os itens relacionados a esta venda devem ser excluídos da tabela de vendas
-- ao mesmo tempo, deve ser possível excluir um item de uma venda 
CREATE TABLE Pedido (
  id uuid default uuid_generate_v4(),
  timestamp DATE,
  id_comprador uuid,
  id_vendedor uuid,
  PRIMARY KEY (id),
  foreign key (id_comprador) REFERENCES Comprador (id),
  foreign key (id_vendedor) REFERENCES Vendedor (id)
);

CREATE TABLE Vendido (
  quantidade INTEGER,
  id_pedido uuid,
  id_produto uuid,
  foreign key (id_pedido) references Pedido(id),
  foreign key (id_produto) references Produto(id),
  PRIMARY KEY (id_pedido, id_produto)
);


CREATE TABLE Endereco (
  id uuid default uuid_generate_v4(),
  rua char (30),
  numero INTEGER,
  cep char (10),
  bairro char (15),
  complemento char (15),
  PRIMARY KEY (id)
);

create table Mora_em (
  cpf_usuario char (11),
  id_endereco uuid,
  primary key (cpf_usuario, id_endereco),
  foreign key (cpf_usuario) references Usuario(cpf),
  foreign key (id_endereco) references Endereco(id)
);

-- criação de view para calcular o volume do produto
CREATE VIEW VolumeProduto (id, nome, volume) AS
SELECT p.id as id_produto,
  p.nome as nome,
  (p.comprimento * p.largura * p.altura) as volume
FROM Produto p;

-- criação de uma visão para apresentar as vendas de um vendedor em um determinado mês, a quantidade de itens vendidos e o valor total das suas vendas
CREATE VIEW VendasPorVendedor (id, quantidade, total) AS
SELECT v.id, count(*), sum(vend.quantidade * prod.custo_unitario), EXTRACT(MONTH FROM p."timestamp") as mes_do_pedido
FROM pedido p
JOIN vendedor v on p.id_vendedor = v.id
JOIN vendido vend on vend.id_pedido = p.id
JOIN produto prod on vend.id_produto = prod.id
GROUP BY v.id, EXTRACT(MONTH FROM p."timestamp");

SELECT * FROM vendasporvendedor;

-- criação de visão para apresentar todos os dados de uma venda específica, o valor total desta venda, o nome do comprador e do vendedor
create view DadosPedido (id, timestamp, id_comprador, id_vendedor, total, nome_comprador, nome_vendedor)AS
SELECT p.id, p."timestamp", c.id, v.id, (vend.quantidade * prod.custo_unitario) as valor_total, usr_comprador.nome, usr_vendedor.nome 
from pedido p
join vendido vend on vend.id_pedido = p.id 
join produto prod on vend.id_produto = prod.id
join comprador c on c.id = p.id_comprador 
join vendedor v on v.id = p.id_vendedor 
join usuario usr_comprador on usr_comprador.cpf = c.cpf_usuario 
join usuario usr_vendedor on usr_vendedor.cpf = v.cpf_usuario;

SELECT *
FROM DadosPedido
WHERE id = 'e80819a4-3e10-11ed-b878-0242ac120002';

-- criação de visão para apresentar o estoque disponível, listando a quantidade de cada item
CREATE VIEW EstoqueAtual (id, quantidade) AS
SELECT p.id,
  (p.estoque - v.vendidos) as estoque
FROM Produto p
INNER JOIN (
  SELECT id_produto, SUM(quantidade) AS vendidos
  FROM Vendido GROUP BY id_produto) v ON p.id = v.id_produto;

-- testes para validar o atendimento dos requisitos apresentados:
-- criando usuários
INSERT INTO Usuario (cpf, nome, sobrenome, email, telefone)
VALUES (
    '72381889450',
    'Chuck',
    'Jones',
    'chuckjones@gmail.com',
    '995458256'
  );
INSERT INTO Usuario (cpf, nome, sobrenome, email, telefone)
VALUES (
    '14748783184',
    'Michael',
    'Maltese',
    'michaelmaltese@gmail.com',
    '997473721'
  );
INSERT INTO Usuario (cpf, nome, sobrenome, email, telefone)
VALUES (
    '22554696772',
    'Geococcyx',
    'Californianus',
    'corredor@gmail.com',
    '997471220'
  );
INSERT INTO Usuario (cpf, nome, sobrenome, email, telefone)
VALUES (
    '79233761665',
    'Canis',
    'Latrans',
    'azarado123@hotmail.com',
    '998123868'
  );
INSERT INTO Usuario (cpf, nome, sobrenome, email, telefone)
VALUES (
    '73381889450',
    'Papa',
    'Leguas',
    'chuckjones@gmail.com',
    '995458256'
  );
  
INSERT INTO Usuario (cpf, nome, sobrenome, email, telefone)
VALUES ('05965350074', 'Kenzo', 'Takada', 'kenzo@gmail.com', '995848256');


-- criando produtos
INSERT INTO Produto (
    id,
    fabricacao_timestamp,
    custo_unitario,
    nome,
    altura,
    comprimento,
    largura,
    massa,
    codigo_barra,
    estoque
  )
VALUES (
    '4b66c5c8-3e10-11ed-b878-0242ac120002',
    TO_TIMESTAMP('2022-02-09 07:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    49.90,
    'CAMISETA EM MEIA MALHA COM ESTAMPA DO PAPA LÉGUAS',
    34,
    94,
    20,
    0.1,
    606063065,
    10
  );
INSERT INTO Produto (
    id,
    fabricacao_timestamp,
    custo_unitario,
    nome,
    altura,
    comprimento,
    largura,
    massa,
    codigo_barra,
    estoque
  )
VALUES (
    '8df94ece-3e10-11ed-b878-0242ac120002',
    TO_TIMESTAMP('2021-03-25 08:40:10', 'YYYY-MM-DD HH24:MI:SS'),
    51.90,
    'Mini Estátua Colecionável Papa-Léguas Road Runner',
    8,
    6,
    4,
    0.3,
    90901872,
    5
  );
INSERT INTO Produto (
    id,
    fabricacao_timestamp,
    custo_unitario,
    nome,
    altura,
    comprimento,
    largura,
    massa,
    codigo_barra,
    estoque
  )
VALUES (
    '9c0fa044-3e10-11ed-b878-0242ac120002',
    TO_TIMESTAMP('2022-06-25 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    4149.00,
    'Geladeira Panasonic Frost Free 483L A+++',
    155,
    65,
    60,
    73,
    8980907523,
    40
  );


  
-- criando endereços
INSERT INTO Endereco (id, rua, numero, cep, bairro, complemento)
VALUES (
    'a75b8544-3e10-11ed-b878-0242ac120002',
    'Av. Unisinos',
    950,
    93022750,
    'Cristo Rei',
    'Universidade'
  );
INSERT INTO Endereco (id, rua, numero, cep, bairro, complemento)
VALUES (
    'b25eba56-3e10-11ed-b878-0242ac120002',
    'Av. Dr. Nilo Peçanha',
    1600,
    91330002,
    'Boa Vista',
    'Campus POA'
  );
INSERT INTO Endereco (rua, numero, cep, bairro, complemento)
VALUES (
    'R. Vinte e Quatro de Maio',
    741,
    93315125,
    'Vila Rosa',
    'Padaria'
  );
INSERT INTO Endereco (id, rua, numero, cep, bairro, complemento)
VALUES (
    'be5842aa-3e10-11ed-b878-0242ac120002',
    'R. Guia Lopes',
    4638,
    93410324,
    'Boa Vista',
    'Loja 1'
  );
  
-- inserindo compradores

INSERT INTO Comprador (id, cartao, cpf_usuario)
VALUES ('fbdf8c00-3e10-11ed-b878-0242ac120002', '5451360035960609', '14748783184');


INSERT INTO Comprador (id, cartao, cpf_usuario)
VALUES ('f6c48b12-3e10-11ed-b878-0242ac120002', '5401815376801937', '72381889450');

-- inserindo vendedores

INSERT INTO Vendedor (id, registro, cpf_usuario)
VALUES ('f23949ac-3e10-11ed-b878-0242ac120002', '5451360035960609', '22554696772');

INSERT INTO Vendedor (id, registro, cpf_usuario)
VALUES ('edcecad6-3e10-11ed-b878-0242ac120002', '909020002', '05965350074');

-- inserindo pedidos
INSERT INTO Pedido (id, timestamp, id_comprador, id_vendedor)
VALUES ('e80819a4-3e10-11ed-b878-0242ac120002', TO_TIMESTAMP('2022-08-25 11:35:04', 'YYYY-MM-DD HH24:MI:SS'), 'f6c48b12-3e10-11ed-b878-0242ac120002', 'f23949ac-3e10-11ed-b878-0242ac120002');

-- inserindo pedidos vendidos
INSERT INTO Vendido (quantidade, id_pedido, id_produto)
VALUES (2, 'e80819a4-3e10-11ed-b878-0242ac120002', '4b66c5c8-3e10-11ed-b878-0242ac120002');
