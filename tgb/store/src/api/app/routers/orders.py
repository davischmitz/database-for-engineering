from fastapi import APIRouter
from app.services import orders

router = APIRouter()

# Para uma sugestão de aplicação em um ambiente real, aplicariamos uma paginação nos registros para não sobrecarregar o banco de dados e ter uma degradação no tempo de resposta da API
@router.get("/orders", tags=["orders"],
    description="Lista todos os pedidos realizados na loja.")
async def get_all():
    return orders.get_all()

@router.get("/orders/{id}", tags=["orders"],
    description="Busca os dados de um pedido pelo identificador dele.")
async def get_by_id(id: str):
    order = orders.find_by_id(id)
    return {
        "status": order._status,
        "timestamp": order._timestamp,
        "id_comprador": order._id_comprador,
        "id_vendedor": order._id_vendedor,
    }

@router.post(
    "/orders/{id}/status",
    tags=["orders"],
    description="Atualiza o status de um pedido"
)
async def update_by_id_and_status(id:str, status: str):
    orders.update_by_id_and_status(id,status)
    return {
        "Pedido atualizado com sucesso."
    }