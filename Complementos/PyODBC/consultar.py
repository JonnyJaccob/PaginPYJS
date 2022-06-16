from bd import conexion

try:
    with conexion.cursor() as cursor:
        # En este caso no necesitamos limpiar ningún dato
        cursor.execute("SELECT id, titulo, año FROM peliculas;")

        # Con fetchall traemos todas las filas
        peliculas = cursor.fetchall()

        # Recorrer e imprimir
        for pelicula in peliculas:
            print(pelicula)
except Exception as e:
    print("Ocurrió un error al consultar: ", e)
finally:
    conexion.close()