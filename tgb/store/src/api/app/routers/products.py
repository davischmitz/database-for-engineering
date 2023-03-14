from fastapi import APIRouter
from app.services import product
from starlette.status import HTTP_204_NO_CONTENT, HTTP_201_CREATED

router = APIRouter()


@router.get(
    "/products",
    tags=["products"],
    description="Lista todos os produtos disponíveis no site",
)
async def get_all():
    return product.get_all()


@router.get(
    "/products/{id}",
    tags=["products"],
    description="Busca o produto do site correspondente ao identificador informado.",
)
async def get_by_id(id: str):
    return product.get_by_id(id)

@router.get(
    "/products/{id}/volume",
    tags=["products"],
    description="Busca o volume do produto ",
)
async def get_volume(id: str):
    return product.get_volume_by_id(id)


@router.post(
    "/products",
    tags=["products"],
    description="Adiciona um novo produto a listagem de produtos a venda no site.",
    status_code=HTTP_201_CREATED,
)
async def create(request: product.ProductDTO):
    product.create(request)
    return request.json()


@router.put(
    "/products/{id}",
    tags=["products"],
    description="Adiciona um novo produto a listagem de produtos a venda no site",
)
async def update(id: str, request: product.ProductDTO):
    product.update(id, request)
    return request.json()


@router.delete(
    "/products/{id}",
    tags=["products"],
    description="Remove um produto do site buscando pelo id",
    status_code=HTTP_204_NO_CONTENT,
)
async def remove(id: str):
    product.delete(id)
