from flask import Flask, render_template, request
import json
import pyodbc
from ConUser import *
import VacioAndNull as CNULL


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

'''
@app.route('/iniciar1.html')
def Iniciar1About():
    return render_template('iniciar1.html')
'''

@app.route('/registrar.html')
def RegistrarAbout():
    return render_template('registrar.html')

@app.route('/home1.html')
def Home1About():
    return render_template('home1.html')

#@app.route('/usuario.html', methods=['POST'])
#def HomeUsuario():
#    return render_template('/usuario.html')

# Routes to Render Something
@app.route('/', methods =["GET", "POST"])
def home():
    return render_template("home1.html")

@app.route('/about', strict_slashes=False)
def about():
    return render_template("about.html")



'''
@app.route('/usuario.html', methods=['POST'])
def usuario():
    nombreUser = request.form['nombreUser']
    contra = request.form['contra']
    usuario = Operacion()
    if CNULL.VAN(nombreUser) and CNULL.VAN(contra):
        if usuario.ExisteNum(nombreUser,contra) == 'si':
            usuario.InicioSesion(nombreUser,contra)
            print("x")
            return render_template("usuario.html", usr=usuario.NumControl, contra = usuario.Contra)
        elif usuario.ExisteCorreo(nombreUser,contra) == 'si':
            usuario.InicioSesionCorreo(nombreUser,contra)
            print("z")
            return render_template("usuario.html", usr=usuario.NumControl, contra = usuario.Contra)
        else:
            return "Error: No se encontro el usuario/datos incorrectos "
    else:
        return "Debes llenar los campos"
'''

'''
@app.route('/usuario.html', methods =["GET", "POST"], endpoint='my_login')
def usuario():
    if request.method == 'POST':
        first_name = request.form.get("fname")
        return redirect(url_for('index'))
    return render_template("usuario.html")
'''


# A decorator used to tell the application
# which URL is associated function
# A decorator used to tell the application
# which URL is associated function
@app.route('/iniciar1.html', methods =["GET", "POST"])
def gfg():
    if request.method == "POST":
        nombreUser = request.form['nombreUser']
        contra = request.form['contra']
        usuario = Operacion()
        if CNULL.VAN(nombreUser) and CNULL.VAN(contra):
            if usuario.ExisteNum(nombreUser,contra) == 'si':
                usuario.InicioSesion(nombreUser,contra)
                print("x")
                return render_template("usuario.html", usr=usuario.NumControl, contra = usuario.Contra)
            elif usuario.ExisteCorreo(nombreUser,contra) == 'si':
                usuario.InicioSesionCorreo(nombreUser,contra)
                print("z")
                return render_template("usuario.html", usr=usuario.NumControl, contra = usuario.Contra)
            else:
                return "Error: No se encontro el usuario/datos incorrectos "
        else:
            return "Debes llenar los campos"
    return render_template("iniciar2.html")


# Make sure this we are executing this file
if __name__ == '__main__':
    app.run(debug=True)