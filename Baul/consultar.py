from bd import conexion

try:
    with conexion.cursor() as cursor:
        # En este caso no necesitamos limpiar ningún dato
        cursor.execute("select * from Alumno " +
                " order by Substring(ID_Alumno,5,3), Substring(ID_Alumno,1,2);")

        # Con fetchall traemos todas las filas
        peliculas = cursor.fetchall()

        # Recorrer e imprimir
        for pelicula in peliculas:
            
            print(tuple(pelicula) )
            print("¬¬¬¬¬")
            list1 = list(pelicula)
            print(list1[0])
except Exception as e:
        print("Ocurrió un error al consultar: ", e)
finally:
        conexion.close()