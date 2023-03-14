from app.database import dependencies
from app.database.crud import product
from pydantic import BaseModel
from decimal import Decimal
import datetime

conn = dependencies.get_connection()

# remover daqui
class ProductDTO(BaseModel):
    fabricacao_timestamp: str
    custo_unitario: str
    nome: str
    altura: str
    comprimento: str
    largura: str
    massa: str
    codigo_barra: str
    estoque: int

def get_all():
    return product.find_all(conn)


def get_by_id(id: str):
    return product.find_by_id(conn, id)

def get_volume_by_id(id: str):
    return product.calculate_volume(conn, id)


def create(dto: ProductDTO):
    return product.create(
        conn,
        dto.fabricacao_timestamp,
        Decimal(dto.custo_unitario),
        dto.nome,
        Decimal(dto.altura),
        Decimal(dto.comprimento),
        Decimal(dto.largura),
        Decimal(dto.massa),
        dto.codigo_barra,
        dto.estoque,
    )


def update(id: str, dto: ProductDTO):
    product.update(
        conn,
        id,
        dto.fabricacao_timestamp,
        Decimal(dto.custo_unitario),
        dto.nome,
        Decimal(dto.altura),
        Decimal(dto.comprimento),
        Decimal(dto.largura),
        Decimal(dto.massa),
        dto.codigo_barra,
        dto.estoque
    )


def delete(id: str):
    return product.delete_by_id(conn, id)
