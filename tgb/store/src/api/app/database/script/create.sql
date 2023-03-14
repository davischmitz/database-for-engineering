create extension "uuid-ossp";

-- exclusão de tabelas para evitar conflito

DROP TABLE IF EXISTS Produto CASCADE;
DROP TABLE IF EXISTS Usuario CASCADE;
DROP TABLE IF EXISTS Comprador CASCADE;
DROP TABLE IF EXISTS Vendedor CASCADE;
DROP TABLE IF EXISTS Pedido CASCADE;
DROP TABLE IF EXISTS Vendido CASCADE;
DROP TABLE IF EXISTS Vendido_Entregue CASCADE;
DROP TABLE IF EXISTS Vendido_Cancelado CASCADE;
DROP TABLE IF EXISTS Endereco CASCADE;
DROP TABLE IF EXISTS Mora_em CASCADE;
DROP TABLE IF EXISTS Pedidos_Cancelados CASCADE;
DROP TABLE IF EXISTS Pedidos_Entregues CASCADE;

-- criação de tabelas

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
  avaliacao INTEGER,
  PRIMARY KEY (id),
  check (altura >= 0 and altura <= 1000),
  check (comprimento >= 0 and comprimento <= 1000),
  check (largura >= 0 and largura <= 1000)
);

CREATE TABLE Usuario (
  cpf CHAR (11),
  nome char (10),
  sobrenome char (30),
  email char (30),
  telefone char (9),
  PRIMARY KEY (cpf)
);

CREATE TABLE usuario_historico (
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
  status char (10),
  timestamp DATE,
  id_comprador uuid,
  id_vendedor uuid,
  PRIMARY KEY (id),
  foreign key (id_comprador) REFERENCES Comprador (id),
  foreign key (id_vendedor) REFERENCES Vendedor (id)
);

CREATE TABLE Pedidos_Entregues (
  id uuid default uuid_generate_v4(),
  timestamp DATE,
  id_comprador uuid,
  id_vendedor uuid,
  PRIMARY KEY (id),
  foreign key (id_comprador) REFERENCES Comprador (id),
  foreign key (id_vendedor) REFERENCES Vendedor (id)
);

CREATE TABLE Pedidos_Cancelados (
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

CREATE TABLE Vendido_Entregue (
  quantidade INTEGER,
  id_pedido uuid,
  id_produto uuid,
  foreign key (id_pedido) references Pedidos_Entregues(id),
  foreign key (id_produto) references Produto(id),
  PRIMARY KEY (id_pedido, id_produto)
);

CREATE TABLE Vendido_Cancelado (
  quantidade INTEGER,
  id_pedido uuid,
  id_produto uuid,
  foreign key (id_pedido) references Pedidos_Cancelados(id),
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

-- criação de uma visão para apresentar as vendas de um vendedor em um determinado mês, a quantidade de itens vendidos e o valor total das suas vendas
CREATE VIEW VendasPorVendedor (id, quantidade, total) AS
SELECT v.id, count(*), sum(vend.quantidade * prod.custo_unitario), EXTRACT(MONTH FROM p."timestamp") as mes_do_pedido
FROM pedido p
JOIN vendedor v on p.id_vendedor = v.id
JOIN vendido vend on vend.id_pedido = p.id
JOIN produto prod on vend.id_produto = prod.id
GROUP BY v.id, EXTRACT(MONTH FROM p."timestamp");

-- criação de visão para apresentar todos os dados de uma venda específica, o valor total desta venda, o nome do comprador e do vendedor
CREATE VIEW DadosPedido (id, timestamp, id_comprador, id_vendedor, total, nome_comprador, nome_vendedor) AS
SELECT p.*,
       vendidos * prod.custo_unitario,
       usr_c.nome,
       usr_v.nome
FROM Pedido p
INNER JOIN
  (SELECT id_produto,
          SUM(quantidade) AS vendidos
   FROM Vendido
   GROUP BY id_produto) v ON p.id = v.id_produto
JOIN Vendedor ON p.id_vendedor = vendedor.id
JOIN Comprador c ON p.id_comprador = c.id
JOIN Produto prod ON v.id_produto = prod.id
JOIN Usuario usr_v ON Vendedor.cpf_usuario = usr_v.cpf
JOIN Usuario usr_c ON c.cpf_usuario = usr_c.cpf;

-- criação de visão para apresentar o estoque disponível, listando a quantidade de cada item
CREATE VIEW EstoqueAtual (id, quantidade) AS
SELECT p.id,
  (p.estoque - v.vendidos) as estoque
FROM Produto p
INNER JOIN (
  SELECT id_produto, SUM(quantidade) AS vendidos
  FROM Vendido GROUP BY id_produto) v ON p.id = v.id_produto;
  
 
 -- criação de trigger

-- trigger de historico do usuario

CREATE OR REPLACE FUNCTION move_historico_usuario()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
			INSERT INTO usuario_historico(cpf, nome, sobrenome, email, telefone)
			VALUES (old.cpf, old.nome, old.sobrenome, old.email, old.telefone);
			return old;
	end;
$$

DROP trigger IF EXISTS MonitoraUsuario ON Usuario;

CREATE TRIGGER MonitoraUsuario 
after delete on Usuario
FOR EACH ROW 
EXECUTE FUNCTION move_historico_usuario();


 



CREATE VIEW VolumeProduto (id, nome, volume) AS
SELECT p.id as id_produto,
  p.nome as nome,
  (p.comprimento * p.largura * p.altura) as volume
FROM Produto p;