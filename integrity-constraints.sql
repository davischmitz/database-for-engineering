create user unisinos with password 'unisinos' createdb;


CREATE TABLE Marinheiros (
	id_marin integer,
	nome char(10),
	avaliacao integer,
	PRIMARY KEY (id_marin),
	CHECK (avaliacao >= 0 AND avaliacao <= 10)
);

insert into marinheiros (id_marin, nome, avaliacao) values (0, 'Marin 1', 10);
insert into marinheiros (id_marin, nome, avaliacao) values (1, 'Marin 2', -1);

create table Transacoes (
	id_transacao serial primary key,
	valor decimal
);

create table Entradas(
	id_entrada serial primary key,
	valor decimal,
	id_transacao integer,
	foreign key (id_transacao) references Transacoes(id_transacao)
);

create table Saidas(
	id_saida serial primary key,
	valor decimal,
	id_transacao integer,
	foreign key (id_transacao) references Transacoes(id_transacao)
);


CREATE OR REPLACE FUNCTION MonitoraEntradas()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.valor > 0 THEN
		 INSERT INTO Entradas(id_transacao, valor)
		 VALUES(new.id_transacao, new.valor);
	ELSE 
		INSERT INTO Saidas(id_transacao, valor)
		VALUES(new.id_transacao, new.valor);
	END IF;

	RETURN NEW;
END;
$$

CREATE TRIGGER MonitoraEntradasTrigger
  after insert 
  ON Transacoes
  FOR EACH ROW
  EXECUTE PROCEDURE MonitoraEntradas();
 
 
insert into transacoes (valor) values(1.5);
insert into transacoes (valor) values(10);
insert into transacoes (valor) values(1.5);
insert into transacoes (valor) values(-5);





CREATE OR REPLACE FUNCTION EvitaDivida()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
declare saldo real;
begin
	saldo := (select sum(t.valor) from transacoes t);
	if (saldo + new.valor) < 0 then
		raise exception 'Saldo Insuficiente (%)', saldo;
	end if;
	RETURN NEW;
END;
$$

CREATE TRIGGER EvitaDividaTrigger
  before insert 
  ON Transacoes
  FOR EACH ROW
  EXECUTE PROCEDURE EvitaDivida();
 
 
insert into transacoes (valor) values(2);
insert into transacoes (valor) values(-10);
insert into transacoes (valor) values(-5);
insert into transacoes (valor) values(-50);
 








