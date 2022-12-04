"""View VendasPorVendedor 
visão para apresentar as vendas de um vendedor em um determinado mês, a quantidade de itens vendidos e o valor total das suas vendas"""

class SalesBySeller:
    def __init__(self, id: int = None, quantidade: int = None, total: int = None):
        self._id = id
        self._quantidade = quantidade
        self._total = total
