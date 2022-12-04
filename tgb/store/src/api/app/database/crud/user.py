from app.database.models.user import User


def find_all(conn):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Usuario")
    result = []
    for item in cursor.fetchall():
        result.append(User(item[0], item[1], item[2], item[3], item[4]))
    return result


def find_by_cpf(conn, cpf: str):
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Usuario WHERE cpf = %s", (cpf,))
    result = cursor.fetchone()
    return User(result[0], result[1], result[2], result[3], result[4])


def create(
    conn,
    cpf: str = None,
    nome: str = None,
    sobrenome: str = None,
    email: str = None,
    telefone: str = None,
):
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO Usuario VALUES(%s,%s,%s,%s,%s)",
        (cpf, nome, sobrenome, email, telefone),
    )


def update(
    conn,
    cpf: str,
    nome: str = None,
    sobrenome: str = None,
    email: str = None,
    telefone: str = None,
):
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE Usuario SET nome = %s, sobrenome = %s, email = %s, telefone = %s WHERE cpf = %s",
        (nome, sobrenome, email, telefone, cpf),
    )


def delete_by_cpf(
    conn,
    cpf: str = None,
):
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Usuario WHERE cpf = %s", (cpf,))
