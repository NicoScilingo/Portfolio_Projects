import requests

def obtener_datos_api():
    # API de ejemplo: Obtendremos información de una API pública
    url = "https://jsonplaceholder.typicode.com/posts"
    response = requests.get(url)
    data = response.json()  # Convertir la respuesta en formato JSON
    return data[:5]  # Devolvemos solo los primeros 5 resultados
