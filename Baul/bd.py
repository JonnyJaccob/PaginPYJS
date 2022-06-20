import pyodbc
direccion_servidor = 'localhost'
nombre_bd = 'webu'
nombre_usuario = 'soporte'
password = 'soporte'
try:
    conexion = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=' +
                              direccion_servidor+';DATABASE='+nombre_bd+';UID='+nombre_usuario+';PWD=' + password)
    # OK! conexión exitosa
    
    print("Conexion exitosa")
except Exception as e:
    # Atrapar error
    print("Ocurrió un error al conectar a SQL Server: ", e)