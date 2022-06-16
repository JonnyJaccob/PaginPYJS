from bd import conexion

try:
    with conexion.cursor() as cursor:
        # En este caso no necesitamos limpiar ningún dato
        cursor.execute("SELECT id, titulo, año FROM peliculas;")
        # Hacer un while, mientras fetchone no regrese None
        pelicula = cursor.fetchone()
        while pelicula:
            print(pelicula)
            pelicula = cursor.fetchone()
except Exception as e:
    print("Ocurrió un error al consultar: ", e)
finally:
    conexion.close()