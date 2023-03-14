from fastapi import APIRouter
from app.services import cart

router = APIRouter()

@router.put(
    "/cart",
    tags=["cart"],
    description="Adiciona um produto no carrinho pelo id que está armazenado no banco.",
)
async def add(cpf:str, id: str):
    return cart.insert(cpf, id)

@router.put(
    "/cart/new_order",
    tags=["cart"],
    description="Fecha os produtos do carrinho em um novo pedido com os produtos que estão no carrinho do usuário.",
)
async def finalize(cpf: str):
    return cart.finish(cpf)
