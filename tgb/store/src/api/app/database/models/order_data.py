"""DadosPedido - view para apresentar todos os dados de uma venda específica, o valor total desta venda, o nome do comprador e do vendedor"""

import datetime

class OrderData:
    def __init__(
        self,
        id: int = None,
        timestamp: datetime = None,
        id_comprador: int = None,
        id_vendedor: int = None,
        total: int = None,
        nome_comprador: str = None,
        nome_vendedor: str = None,
    ):
        self._id = id
        self._timestamp = timestamp
        self._id_comprador = id_comprador
        self._id_vendedor = id_vendedor
        self._total = total
        self._nome_comprador = nome_comprador
        self._nome_vendedor = nome_vendedor
