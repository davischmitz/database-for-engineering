from app.database.models.product import Product
from app.database.models.product_volume import ProductVolume
import datetime
from decimal import Decimal


def find_all(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Produto")
    result = []
    for item in cursor.fetchall():
        result.append(
            Product(
                item[0],
                item[1],
                item[2],
                item[3],
                item[4],
                item[5],
                item[6],
                item[7],
                item[8],
                item[9],
            )
        )
    return result


def find_by_id(conn, id: str):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Produto WHERE id = %s", (id,))
    result = cursor.fetchone()
    return Product(
        result[0],
        result[1],
        result[2],
        result[3],
        result[4],
        result[5],
        result[6],
        result[7],
        result[8],
        result[9],
    )


def create(
    conn,
    fabricacao_timestamp: datetime = None,
    custo_unitario: Decimal = None,
    nome: str = None,
    altura: Decimal = None,
    comprimento: Decimal = None,
    largura: Decimal = None,
    massa: Decimal = None,
    codigo_barra: str = None,
    estoque: int = None,
):
    cursor = conn.cursor()
    cursor.execute(
        """INSERT INTO Produto (fabricacao_timestamp, custo_unitario, nome, altura, comprimento, largura, massa, codigo_barra, estoque) 
        VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s)""",
        (
            fabricacao_timestamp,
            custo_unitario,
            nome,
            altura,
            comprimento,
            largura,
            massa,
            codigo_barra,
            estoque,
        ),
    )


def update(
    conn,
    id: str,
    fabricacao_timestamp: datetime = None,
    custo_unitario: Decimal = None,
    nome: str = None,
    altura: Decimal = None,
    comprimento: Decimal = None,
    largura: Decimal = None,
    massa: Decimal = None,
    codigo_barra: str = None,
    estoque: int = None,
):
    cursor = conn.cursor()
    cursor.execute(
        """UPDATE Produto SET 
        fabricacao_timestamp = %s,
        custo_unitario = %s,
        nome = %s,
        altura = %s,
        comprimento = %s,
        largura = %s,
        massa = %s,
        codigo_barra = %s,
        estoque = %s
      WHERE id = %s""",
        (
            fabricacao_timestamp,
            custo_unitario,
            nome,
            altura,
            comprimento,
            largura,
            massa,
            codigo_barra,
            estoque,
            id
        ),
    )


def delete_by_id(
    conn,
    id: str = None,
):
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Produto WHERE id = %s", (id,))


def calculate_volume(conn, id: str = None):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM VolumeProduto where id = %s", (id,))
    result = cursor.fetchone()
    return ProductVolume(result[0], result[1], result[2])
