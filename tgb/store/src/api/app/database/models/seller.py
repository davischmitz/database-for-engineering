"""Table Vendedor"""

class Seller:
    def __init__(self, id: int = None, registro: str = None, cpf_usuario: str = None):
        self._id = id
        self._registro = registro
        self._cpf_usuario = cpf_usuario
