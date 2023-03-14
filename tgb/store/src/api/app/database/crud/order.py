from app.database.models.order import Order
# using time module
import time

def find_all(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Pedido")
    retorno = []
    for item in cursor.fetchall():
        retorno.append(Order(item[0], item[1], item[2], item[3], item[4]))
    return retorno

def find_by_id(conn, id):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Pedido WHERE id = %s", (id,))
    for item in cursor.fetchall():
        return Order(item[0], item[1], item[2], item[3], item[4])
    return None

def create(conn, id, id_products):
    cursor = conn.cursor()
    id_vendedor = "231f342343"
    cursor.execute(
        "INSERT INTO Pedido VALUES(%s,%s,%s,%s)",
        (
        "Criado",
        time.time(),
        id,
        id_vendedor
        ) 
    )
    return "Pedido realizado com sucesso"

def update_by_id(conn, id, status):
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE Pedido set status = %s WHERE id = %s", (status, id)
    )
