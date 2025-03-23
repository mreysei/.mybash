Para enviar notificaciones a Telegram cuando el servicio SSH se apaga o se enciende, puedes crear un script que monitoree el estado del servicio `ssh` y envíe notificaciones a Telegram cuando detecte un cambio. Aquí te explico cómo hacerlo:

---

### 1. **Crear un Script para Monitorear el Servicio SSH**
Este script verificará el estado del servicio `ssh` y enviará una notificación a Telegram cuando se detecte un cambio (encendido o apagado).

#### Script: `monitor_ssh.sh`
```bash
#!/bin/bash

# Configuración
BOT_TOKEN="TU_TOKEN_DEL_BOT"
CHAT_ID="TU_ID_DEL_CANAL"
SERVICE="ssh"

# Función para enviar mensajes a Telegram
send_telegram() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$message" \
        -d "parse_mode=HTML"
}

# Verificar el estado del servicio SSH
check_service() {
    if systemctl is-active --quiet $SERVICE; then
        echo "🟢 El servicio $SERVICE está <b>activo</b>."
    else
        echo "🔴 El servicio $SERVICE está <b>inactivo</b>."
    fi
}

# Monitorear cambios en el estado del servicio
previous_status=$(systemctl is-active $SERVICE)
while true; do
    current_status=$(systemctl is-active $SERVICE)
    if [[ $current_status != $previous_status ]]; then
        message=$(check_service)
        send_telegram "$message"
        previous_status=$current_status
    fi
    sleep 5  # Verificar cada 5 segundos
done
```

---

### 2. **Hacer que el Script sea Ejecutable**
Guarda el script en un archivo, por ejemplo, `/usr/local/bin/monitor_ssh.sh`, y hazlo ejecutable:
```bash
sudo chmod +x /usr/local/bin/monitor_ssh.sh
```

---

### 3. **Configurar el Script para que se Ejecute en Segundo Plano**
Para que el script se ejecute automáticamente en segundo plano, puedes crear un servicio systemd.

#### Archivo de Servicio: `/etc/systemd/system/monitor-ssh.service`
```ini
[Unit]
Description=Monitor SSH Service and Send Telegram Notifications
After=network.target

[Service]
ExecStart=/usr/local/bin/monitor_ssh.sh
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

---

### 4. **Habilitar y Iniciar el Servicio**
1. Recarga systemd para que reconozca el nuevo servicio:
   ```bash
   sudo systemctl daemon-reload
   ```
2. Inicia el servicio:
   ```bash
   sudo systemctl start monitor-ssh
   ```
3. Habilita el servicio para que se inicie automáticamente al arrancar el sistema:
   ```bash
   sudo systemctl enable monitor-ssh
   ```

---

### 5. **Probar la Configuración**
1. Detén el servicio SSH manualmente:
   ```bash
   sudo systemctl stop ssh
   ```
   Deberías recibir una notificación en Telegram indicando que el servicio está inactivo.

2. Inicia el servicio SSH manualmente:
   ```bash
   sudo systemctl start ssh
   ```
   Deberías recibir una notificación en Telegram indicando que el servicio está activo.

---

### 6. **Integrar con Fail2Ban (Opcional)**
Si ya tienes configurado Fail2Ban para enviar notificaciones a Telegram, este script funcionará de manera independiente. Sin embargo, puedes combinar ambas funcionalidades en un solo script si lo prefieres.

---

### Notas Finales
- Asegúrate de reemplazar `TU_TOKEN_DEL_BOT` y `TU_ID_DEL_CANAL` con los valores correctos de tu bot y canal de Telegram.
- El script verifica el estado del servicio cada 5 segundos. Puedes ajustar este intervalo modificando el valor de `sleep` en el script.
- Si el servicio `ssh` no está instalado o tiene un nombre diferente en tu sistema, asegúrate de ajustar la variable `SERVICE` en el script.

¡Con esto, recibirás notificaciones en Telegram cada vez que el servicio SSH se apague o se encienda! 😊
