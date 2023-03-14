"""Table Produto"""

import datetime

class Product:
    def __init__(
        self,
        id: int = None,
        fabricacao_timestamp: datetime = None,
        custo_unitario: float = None,
        nome: str = None,
        altura: float = None,
        comprimento: float = None,
        largura: float = None,
        massa: float = None,
        codigo_barra: str = None,
        estoque: int = None,
    ):
        self.id = id
        self.fabricacao_timestamp = fabricacao_timestamp
        self.custo_unitario = custo_unitario
        self.nome = nome
        self.altura = altura
        self.comprimento = comprimento
        self.largura = largura
        self.massa = massa
        self.codigo_barra = codigo_barra
        self.estoque = estoque
