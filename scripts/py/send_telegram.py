#!/usr/bin/env python3
import requests
import sys

# Configuración
BOT_TOKEN = '7582837330:AAFRs38nNECZetpwxj7sPb7uVhog-dAvcZg'
CHAT_ID = '-1002193574586'

# Mensaje a enviar
message = sys.argv[1]

# Enviar mensaje a Telegram
url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
payload = {
    'chat_id': CHAT_ID,
    'text': message,
    'parse_mode': 'HTML'
}
response = requests.post(url, data=payload)

# Verificar respuesta
if response.status_code != 200:
    print(f"Error al enviar el mensaje: {response.text}")
