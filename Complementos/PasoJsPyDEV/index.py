import json
from flask import request
from flask import Flask, render_template
app = Flask(__name__)

nombre= "nulo"
apellido="nulo"
texto = "..."

@app.route('/')
def menu():
 return render_template('menu.html')

@app.route('/plantilla.html')
def plantilla():
    
    return render_template('plantilla.html',nombre=nombre,apellido=apellido, texto=texto)

@app.route('/test', methods=['POST'])
def test():
    output = request.get_json()
    print(output) # This is the output that was stored in the JSON within the browser
    print(type(output))
    result = json.loads(output) #this converts the json output to a python dictionary
    print(result) # Printing the new dictionary
    print(type(result))#this shows the json converted as a python dictionary
    global texto
    texto = result
    result1 = len(result.split('","',3))
    global nombre 
    nombre = result1 #Variable global
    print(nombre)
    return render_template('plantilla.html',nombre=nombre,apellido=apellido, texto=texto)


if __name__ == '__main__':
    app.run(debug=True)
    
