from flask import Flask, render_template, jsonify
import requests
from api.external_api import obtener_datos_api

app = Flask(__name__)

# Ruta principal
@app.route('/')
def home():
    return render_template('index.html')

# Ruta para la página de "Acerca de"
@app.route('/about')
def about():
    return render_template('about.html')

# Ruta para obtener datos de una API externa
@app.route('/api/data')
def api_data():
    data = obtener_datos_api()
    return jsonify(data)

# Ruta para mostrar un mensaje de bienvenida con un toque dinámico
@app.route('/welcome/<name>')
def welcome(name):
    return render_template('welcome.html', name=name)

if __name__ == '__main__':
    app.run(debug=True)

