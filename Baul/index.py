from flask import Flask, render_template, request
import json
import pyodbc


app = Flask(__name__)

Prueba = "Vacio" 

# Creating simple Routes 
@app.route('/test')
def test():
    return "Home Page"

@app.route('/test/about/')
def about_test():
    return "About Page"

@app.route('/iniciar.html')
def IniciarAbout():
    return render_template('iniciar.html')

@app.route('/registrar.html')
def RegistrarAbout():
    return render_template('registrar.html')

@app.route('/home1.html')
def Home1About():
    return render_template('home1.html')

# Routes to Render Something
@app.route('/')
def home():
    return render_template("home1.html")

@app.route('/about', strict_slashes=False)
def about():
    return render_template("about.html")

# Make sure this we are executing this file
if __name__ == '__main__':
    app.run(debug=True)
    
@app.route('/usuario.html', methods=['POST'])
def usuario():
    nombreUser = request.form['nombreUser']
    contra = request.form['contra']
    return render_template("usuario.html", nombreUser=nombreUser)


