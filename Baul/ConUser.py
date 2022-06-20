from bd import conexion

class Operacion:
    def __init__(self, user, contra):
        self.User = user
        self.Contra = contra
    
        
    @classmethod
    def InicioSesion(cls):
        try:
            with conexion.cursor() as cursor:
                # En este caso no necesitamos limpiar ningún dato
                cursor.execute("select c.ID_Alumno, c.correo, c.Contraseña, a.Nombre, a.Apellido_Paterno, a.Apellido_Materno, a.Fecha_Nacimiento, a.Fecha_Ingreso, a.carrera, a.Semestre "+
                        " from cuenta c join alumno a on (a.Id_Alumno = c.Id_Alumno) "+
                        " where c.ID_Alumno = '"+cls.User+"' and c.Contraseña = '"+cls.Contra+"' ")

                # Con fetchall traemos todas las filas
                peliculas = cursor.fetchall()

                # Recorrer e imprimir
                for pelicula in peliculas:
                    #Convertimos el resultado a una lista-arreglo
                    list1 = list(pelicula)
                    print(list1[0])
        except Exception as e:
            print("Ocurrió un error al consultar: ", e)
        finally:
            conexion.close()