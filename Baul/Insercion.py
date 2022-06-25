from bd import conexion

def Insertar(nombre,apellidop,apellidom,genero,fechaN,fechaIng,Carrera):
    try:
        with conexion.cursor() as cursor:
            consulta = "exec DarAltaAlumno ?, ?, ?, ?, '?', '?', '?';"
            print(f"Nombre(s): {nombre} Apellido Paterno: {apellidop} Apellido Materno: {apellidom} Genero: {genero} Fecha: {fechaN} Fecha Ingreso: {fechaIng} Carrera: {Carrera}")
            GNum = 1
            if genero == 'Hombre':
                GNum = 1
            else:
                GNum = 0
            consulta = f"exec DarAltaAlumno {nombre}, {apellidop}, {apellidom}, {GNum}, '{fechaN}', '{fechaIng}', '{Carrera}';"
            #cursor.execute(consulta, (nombre, apellidop, apellidom, GNUM, fechaN, FechaIng, Carrera))
            cursor.execute(consulta)
            print('Insercion exitosa')
            # No olvidemos hacer commit cuando hacemos un cambio a la BD
            conexion.commit()
    except Exception as e:
        print("Ocurrió un error al insertar: ", e)
    finally:
        conexion.close()