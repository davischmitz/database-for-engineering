"""View EstoqueAtual
visão para apresentar o estoque disponível, listando a quantidade de cada item """

class CurrentInventory:
    def __init__(self, id: int = None, quantidade: int = None):
        self._id = id
        self._quantidade = quantidade
