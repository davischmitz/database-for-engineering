"""Table Pedido

-- ao excluir um Pedido, todos os itens relacionados a esta venda devem ser excluídos da tabela de vendas
-- ao mesmo tempo, deve ser possível excluir um item de uma venda 
"""

import datetime

class Order:
    def __init__(
        self,
        id: int = None,
        status: str = None,
        timestamp: datetime = None,
        id_comprador: int = None,
        id_vendedor: int = None
    ):
        self._id = id
        self._status = status
        self._timestamp = timestamp
        self._id_comprador = id_comprador
        self._id_vendedor = id_vendedor
