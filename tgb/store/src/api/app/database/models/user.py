class User:
    def __init__(
        self,
        cpf: str = None,
        nome: str = None,
        sobrenome: str = None,
        email: str = None,
        telefone: str = None,
    ):
        self._cpf = cpf
        self._nome = nome
        self._sobrenome = sobrenome
        self._email = email
        self._telefone = telefone
