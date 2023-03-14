import psycopg2

conexao = psycopg2.connect(host="localhost",
                            dbname="postgres",
                            user="postgres",
                            password="postgres")

cursor = conexao.cursor()

"""
create table Marinheiros (
  id_marin integer primary key,
  nome_marin text,
  avaliacao integer,
  idade real
);
"""

class Marinheiro:

    def __init__(self,id_marin:int=None,
                 nome:str = None,
                 avaliacao:int = None,
                 idade:float = None) -> None:
        self._id = id_marin
        self._nome = nome
        self._avaliacao = avaliacao
        self._idade = idade

    def criar(self,nome:str=None, avaliacao:int = None, idade:float = None):
        self._nome = nome
        self._avaliacao = avaliacao
        self._idade = idade
        cursor.execute("INSERT INTO Marinheiros VALUES(10,%s,%s,%s)",(nome,avaliacao,idade));
        conexao.commit()
        print("Marinheiro criado com sucesso")
    
    def from_object(self,objeto:dict):
        self._id = objeto.get("id_marin")
        self._nome = objeto.get("nome")
        self._avaliacao = objeto.get("avaliacao")
        self._idade = objeto.get("idade")
    
    def to_object(self)->dict:
        return {"id_marin":self._id, "nome":self._nome, "avaliacao":self._avaliacao,"idade":self._idade}

    def selec_by_id(self,id_marin:int):
        cursor.execute("SELECT * from Marinheiros WHERE id_marin=%s",(id_marin,))
        self._id,self._nome, self._avaliacao, self._idade = cursor.fetchone()

    def pode_dirigir_porta_avioes(self):
        if self._avaliacao<9:
            return False
        return True

    def __repr__(self) -> str:
        return f"Marinheiro(Nome:{self._nome}, ID: {self._id})"

class Marinheiros:

    def busca_todos_marinheiros(self):
        cursor.execute("SELECT * FROM Marinheiros;")
        retorno = []
        for item in cursor.fetchall():
            retorno.append(Marinheiro(item[0],item[1],item[2],item[3]))
        return retorno

if __name__ == "__main__":
    lista_marinheiros = Marinheiros().busca_todos_marinheiros()
    for marinheiro in lista_marinheiros:
        print(marinheiro)