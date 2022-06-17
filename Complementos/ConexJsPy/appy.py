from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def get_data():
    name = 'Alfonso'
    return render_template('indexPrueba.html', name = name)

if __name__ == '__main__':
    app.run(debug=True)