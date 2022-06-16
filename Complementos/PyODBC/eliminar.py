from bd import conexion
try:
    with conexion.cursor() as cursor:

        consulta = "DELETE FROM peliculas WHERE anio < ?;"
        año = 2000
        cursor.execute(consulta, (año))

    # No olvidemos hacer commit cuando hacemos un cambio a la BD
    conexion.commit()
except Exception as e:
    print("Error eliminando: ", e)
finally:
    conexion.close()