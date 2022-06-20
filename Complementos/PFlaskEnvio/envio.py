from pickle import TRUE
from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def template():
    #Renderizamos la plantilla. formulario html
    # templates/from.html
    return render_template("form.html")

# Definimos el route con el metodo POST
@app.route('/usuario',methods=['POST'])
def usuario():
    # Obtenemos la informacion del parametro "nombreUser"
    #Esto lo hacemos con el diccionario "form"
    nombreUser = request.form['nombreUser']
    
    #Retornamos la respuesta
    return "<h1>Bienvenido "+ nombreUser + "</h1>"

if __name__ == '__main__':
    #Iniciamos en modo debug
    app.run(debug=TRUE)