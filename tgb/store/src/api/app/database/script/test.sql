
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
INSERT INTO Pedido (id, timestamp, status, id_comprador, id_vendedor)
VALUES ('e80819a4-3e10-11ed-b878-0242ac120002', TO_TIMESTAMP('2022-08-25 11:35:04', 'YYYY-MM-DD HH24:MI:SS'), 'Criado', 'f6c48b12-3e10-11ed-b878-0242ac120002', 'f23949ac-3e10-11ed-b878-0242ac120002');

-- inserindo pedidos vendidos
INSERT INTO Vendido (quantidade, id_pedido, id_produto)
VALUES (2, 'e80819a4-3e10-11ed-b878-0242ac120002', '4b66c5c8-3e10-11ed-b878-0242ac120002');


-- atualizando os status do pedido
update Pedido set status = 'Preparação' where id = 'e80819a4-3e10-11ed-b878-0242ac120002';
update Pedido set status = 'Transporte' where id = 'e80819a4-3e10-11ed-b878-0242ac120002';
update Pedido set status = 'Entregue' where id = 'e80819a4-3e10-11ed-b878-0242ac120002';
update Pedido set status = 'Cancelado' where id = 'e80819a4-3e10-11ed-b878-0242ac120002';


select * from vendido v;
select * from pedido;
select * from pedidos_entregues pe;
select * from pedidos_cancelados pc;
select * from vendido_entregue ve;
select * from vendido_cancelado vc;

delete from vendido_cancelado;
delete from vendido_entregue;
delete from vendido;
delete from pedido;
delete from pedidos_entregues pe;
delete from pedidos_cancelados pc;

