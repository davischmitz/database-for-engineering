from app.database import dependencies
from app.database.crud import order

conn = dependencies.get_connection()

def get_all():
    return order.find_all(conn)

def find_by_id(id:str):
    return order.find_by_id(conn, id)

def create(cpf:str, id_products:str):
    return order.create(conn, cpf, id_products)

def update_by_id_and_status(id:str, status:str):
    return order.update_by_id(conn, id, status)
