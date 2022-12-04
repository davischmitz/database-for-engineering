from app.database import dependencies
from app.database.crud import user
from pydantic import BaseModel

conn = dependencies.get_connection()

#remover daqui
class CreateUserDTO(BaseModel):
  cpf: str
  nome: str
  sobrenome: str
  email: str
  telefone: str

class UpdateUserDTO(BaseModel):
  nome: str
  sobrenome: str
  email: str
  telefone: str

def get_all():
    return user.find_all(conn)

def get_by_cpf(cpf: str):
    return user.find_by_cpf(conn, cpf)

def update(cpf: str, dto: UpdateUserDTO):
    user.update(conn, cpf, dto.nome, dto.sobrenome, dto.email, dto.telefone)

def create(dto: CreateUserDTO):
    return user.create(conn, dto.cpf, dto.nome, dto.sobrenome, dto.email, dto.telefone)

def delete(cpf: str):
    return user.delete_by_cpf(conn, cpf)