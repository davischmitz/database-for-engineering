"""Table Endereco"""

class Address:
    def __init__(
        self,
        id: int = None,
        rua: str = None,
        numero: int = None,
        cep: str = None,
        bairro: str = None,
        complemento: str = None,
    ):
        self._id = id
        self._rua = rua
        self._numero = numero
        self._cep = cep
        self._bairro = bairro
        self._complemento = complemento
