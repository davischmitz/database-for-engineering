"""
Table Pedidos_Cancelados 
"""

import datetime

class CanceledOrders:
    def __init__(
        self,
        id: int = None,
        timestamp: datetime = None,
        id_comprador: int = None,
        id_vendedor: int = None,
    ):
        self._id = id
        self._timestamp = timestamp
        self._id_comprador = id_comprador
        self._id_vendedor = id_vendedor
