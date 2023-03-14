import psycopg2

def get_connection():
    conn =  psycopg2.connect(
        host="localhost", dbname="postgres", user="postgres", password="postgres"
    )
    conn.autocommit = True;
    return conn;
