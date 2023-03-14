from fastapi import APIRouter
from app.services import user
from starlette.status import HTTP_204_NO_CONTENT, HTTP_201_CREATED

router = APIRouter()


@router.get("/users", tags=["users"])
async def get_all():
    return user.get_all()


@router.post(
    "/users",
    tags=["users"],
    description="Criar um novo perfil de usuário no site",
    status_code=HTTP_201_CREATED,
)
async def create(request: user.CreateUserDTO):
    user.create(request)
    return request.json()


@router.put(
    "/users/{cpf}",
    tags=["users"],
    description="Atualizar um perfil de usuário no site.",
)
async def update(cpf: str, request: user.UpdateUserDTO):
    user.update(cpf, request)
    return request.json()


@router.delete(
    "/users/{cpf}",
    tags=["users"],
    description="Remove um perfil de usuário no site.",
    status_code=HTTP_204_NO_CONTENT,
)
async def delete(cpf: str):
    user.delete(cpf)
