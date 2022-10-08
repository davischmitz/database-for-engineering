Exercícios Álgebra Relacional

Dados:

/***
group: Exercicio 1 


Fornecedores={
	id_forn:number, nome_forn:string, endereco:string
	1, f1, 'rua a'
	2, f2, 'rua b'
	3, f3, 'Av. Packer, 221'
}

Pecas = {
	id_peca:number, nome_peca:string, cor:string
	1, p1, vermelha
	2, p2, azul
	3, p3, verde
	4, p4, amarela
}

Catalogo = {
	id_forn:number, id_peca:number, custo:number
	1, 1, 1
	1, 2, 1.5
	2, 1, 1
	2, 2, 2
	2, 3, 2
	2, 4, 5
	3, 2, 2
	3, 3, 2
}
***/

1)a) 
Encontre os nomes dos fornecedores que fornecem alguma peça vermelha.

π nome_forn (((σ cor='vermelha' Pecas) ⨝ Catalogo) ⨝ Fornecedores)

select nome_forn
from (select * from Pecas where cor = 'vermelha') as pecas
join Catalogo on Catalogo.id_peca = pecas.id_peca
join Fornecedores on Fornecedores.id_forn = Catalogo.id_forn;


b)
Encontre os id-forns dos fornecedores que fornecem alguma peça vermelha ou verde.

π nome_forn (((σ cor='vermelha' ∨ cor='verde' Pecas) ⨝ Catalogo) ⨝ Fornecedores)

select nome_forn
from (select * from Pecas where cor = 'vermelha' or cor = 'verde') as pecas
join Catalogo on Catalogo.id_peca = pecas.id_peca
join Fornecedores on Fornecedores.id_forn = Catalogo.id_forn

c) 
Encontre os id-forns dos fornecedores que fornecem alguma peça vermelha ou que estão no endereço Av.Packer,221.

π id_forn (((σ cor='verde' Pecas) ∪ (σ endereco='Av. Packer, 221' Fornecedores)) ⨝ Catalogo)

select f.id_forn
from (select * from Fornecedores where endereco = 'Av. Packer, 221') as f
join Catalogo on f.id_forn = Catalogo.id_forn
union
select Catalogo.id_forn
from (select * from Pecas where cor = 'verde') as p
join Catalogo on p.id_peca = Catalogo.id_peca;

d)
