from app.database import dependencies
from app.services import orders

cursor = dependencies.get_connection()

# Creating an empty Dictionary, key = cpf; value = ids de produto
cart_dict = dict()

def insert(cpf:str, id_product:str):
    products = []
    products.append(id_product)

    if cart_dict.has_key(cpf):
        current_value = cart_dict[cpf]
        products.append(current_value)
        cart_dict[cpf] = products
    else:
        cart_dict[cpf] = id_product
    return "Produto inserido no carrinho!"

def finish(cpf:str):
    return orders.create(cursor, cpf, cart_dict[cpf])
