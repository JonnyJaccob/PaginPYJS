from asyncio.windows_events import NULL
from bd import conexion

class Operacion:
    
    
    Contra = ""
    NumControl = ""
    Correo = ""
    Nombre = ""
    ApellidoP = ""
    ApellidoM = ""
    FechaN = ""
    FechaIng = ""
    Carrera = ""
    Semestre  = ""
    
    def __init__(self):
        self = self
    
        
    @classmethod
    def InicioSesion(cls,usr,cont):
        try:
            with conexion.cursor() as cursor:
                # En este caso no necesitamos limpiar ningún dato
                cursor.execute("select c.ID_Alumno, c.correo, c.Contraseña, a.Nombre, a.Apellido_Paterno, a.Apellido_Materno, a.Fecha_Nacimiento, a.Fecha_Ingreso, a.carrera, a.Semestre "+
                        " from cuenta c join alumno a on (a.Id_Alumno = c.Id_Alumno) "+
                        f" where c.ID_Alumno = '{usr}' and c.Contraseña = '"+cont+"' ")

                # Con fetchall traemos todas las filas
                peliculas = cursor.fetchall()

                # Recorrer e imprimir
                for pelicula in peliculas:
                    #Convertimos el resultado a una lista-arreglo
                    list1 = list(pelicula)
                    print(pelicula)
                    cls.NumControl = list1[0]
                    cls.Correo = list1[1]
                    cls.Nombre = list1[2]
                    cls.ApellidoP = list1[3]
                    cls.ApellidoM = list1[4]
                    cls.FechaN = list1[5]
                    cls.FechaIng = list1[6]
                    cls.Carrera = list1[7]
                    cls.Semestre  = list1[8]
                    
                
        except Exception as e:
            print("Ocurrió un error al consultar: ", e)
        
            
    
    def InicioSesionCorreo(cls,correo,cont):
        try:
            with conexion.cursor() as cursor:
                # En este caso no necesitamos limpiar ningún dato
                cursor.execute("select c.ID_Alumno, c.correo, c.Contraseña, a.Nombre, a.Apellido_Paterno, a.Apellido_Materno, a.Fecha_Nacimiento, a.Fecha_Ingreso, a.carrera, a.Semestre "+
                        " from cuenta c join alumno a on (a.Id_Alumno = c.Id_Alumno) "+
                        f" where c.Correo = '{correo}' and c.Contraseña = '"+cont+"' ")

                # Con fetchall traemos todas las filas
                peliculas = cursor.fetchall()

                # Recorrer e imprimir
                for pelicula in peliculas:
                    #Convertimos el resultado a una lista-arreglo
                    list1 = list(pelicula)
                    print(pelicula)
                    cls.NumControl = list1[0]
                    cls.Correo = list1[1]
                    cls.Nombre = list1[2]
                    cls.ApellidoP = list1[3]
                    cls.ApellidoM = list1[4]
                    cls.FechaN = list1[5]
                    cls.FechaIng = list1[6]
                    cls.Carrera = list1[7]
                    cls.Semestre  = list1[8]
                    
                
        except Exception as e:
            print("Ocurrió un error al consultar: ", e)
        
    
    def ExisteCorreo(cls,correo,cont):
        try:
            with conexion.cursor() as cursor:
                # En este caso no necesitamos limpiar ningún dato
                cursor.execute(f"select case when exists(select ID_Alumno from cuenta where Correo = '{correo}' and Contraseña = '{cont}') then 'si' else 'no' end as Existe")
                peliculas = cursor.fetchall()
                for pelicula in peliculas:
                    list1 = list(pelicula)
                    print(list1[0])
                    if (list1[0] == 'si'):
                        return 'si'
                    else:
                        return 'no'
                    
        except Exception as e:
            print("Ocurrió un error al consultar: ", e)
       
            
    def ExisteNum(cls,Num,cont):
        
        try:
            with conexion.cursor() as cursor:
                cursor.execute(f"select case when exists(select ID_Alumno from cuenta where ID_Alumno = '{Num}' and Contraseña = '{cont}') then 'si' else 'no' end as Existe")
                peliculas = cursor.fetchall()
                for pelicula in peliculas:
                    list1 = list(pelicula)
                    print(list1[0])
                    if (list1[0] == 'si'):
                        return 'si'
                    else:
                        return 'no'
        except Exception as e:
            print("Ocurrió un error al consultar: ", e)
        #finally:
            #conexion.close() #al parecer esto provoco el error
            
    def __exit__(self, *args):
        self._cursor.close()
        self._connection.close()