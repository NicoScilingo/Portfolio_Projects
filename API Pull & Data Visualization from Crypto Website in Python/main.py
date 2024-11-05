import requests
import pandas as pd
from datetime import datetime
import json
import matplotlib.pyplot as plt
from requests import Session, ConnectionError, Timeout, TooManyRedirects
import seaborn as sns

# API KEY driectly in the code from CoinMarketCap
API_KEY = 'c0bbe13f-8ef7-4011-81aa-951f9989b8f7'

url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
parameters = {
    'start': '1',
    'limit': '20',
    'convert': 'USD'
}
headers = {
    'Accepts': 'application/json',
    'X-CMC_PRO_API_KEY': API_KEY,
}

if __name__ == "__main__":
    session = Session()
    session.headers.update(headers)

    try:
        response = session.get(url, params=parameters)
        response.raise_for_status()  # Verifying if there is an answer
        data = response.json()  # Using .json()
        print(json.dumps(data, indent=4))  # Formatting json to print it

    except (ConnectionError, Timeout, TooManyRedirects) as e:
        print(f"Error en la conexión: {e}")
    except requests.exceptions.HTTPError as http_err:
        print(f"Error HTTP: {http_err}")


type(data)

pd.set_option('display.max.columns', None)
pd.set_option('display.max.rows', None)

df = pd.json_normalize(data['data'])
df['timestamp'] = pd.to_datetime('now')
df

# Automating the Data Pull

def api_runner():
    global df
    url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
    parameters = {
      'start':'1',
      'limit':'20',
      'convert':'USD'
    }
    headers = {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': 'c0bbe13f-8ef7-4011-81aa-951f9989b8f7',
    }
    
    session = Session()
    session.headers.update(headers)
    
    try:
      response = session.get(url, params=parameters)
      data = json.loads(response.text)
      #print(data)
    except (ConnectionError, Timeout, TooManyRedirects) as e:
      print(e)
    df2 = pd.json_normalize(data['data'])
    df2['timestamp'] = pd.to_datetime('now')
    df_append = pd.DataFrame(df2)
    df = pd.concat([df,df_append])

    if not os.path.isfile(r'C:\Users\nico_\OneDrive\Escritorio\DataScience\Python\API_Crypto.csv'):
        df.to_csv(r'C:\Users\nico_\OneDrive\Escritorio\DataScience\Python\API_Crypto.csv', header = 'column_names')
    else:
        df.to_csv(r'C:\Users\nico_\OneDrive\Escritorio\DataScience\Python\API_Crypto.csv', mode = 'a', header = False)

import os
from time import time
from time import sleep

# these are going to give us the ability to track the time and run through and call this function in certain intervals that we want

max_runs = 3  # Max number of executions
for i in range(max_runs):
    api_runner()
    print('API Runner Completed Successfully')
    sleep(60)  # Sleep for 1 minute
print("API Pull completed after {} runs.".format(max_runs))


# Transforming
df = pd.read_csv('API_Crypto.csv')
pd.set_option('display.float_format', lambda x: '%.5f' % x)
df_grouped = df.groupby('name', sort=False)[
    ['quote.USD.percent_change_1h', 'quote.USD.percent_change_24h', 'quote.USD.percent_change_7d', 
     'quote.USD.percent_change_30d', 'quote.USD.percent_change_60d', 'quote.USD.percent_change_90d']].mean()

# Visualizing All Data
df_melted = df_grouped.reset_index().melt(id_vars=["name"], var_name="percent_change", value_name="values")
sns.catplot(x='percent_change', y='values', hue='name', data=df_melted, kind='point')
plt.show()

# Specific Visualization for BTC
df_btc = df.query("name == 'Bitcoin'")
sns.lineplot(x='timestamp', y='quote.USD.price', data=df_btc)
plt.show()