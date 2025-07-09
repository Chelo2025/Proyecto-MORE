# 🛡️ Proyecto MORE (Monitoreo, Observación, Registro y Evaluación)

Un proyecto simple de telemetría del sistema desarrollado en Bash, pensado para registrar cada 10 segundos el estado del sistema.

Fue ejecutado en **servidores Debian 12 sin entorno gráfico**.

---

## 🚀 ¿Qué hace este script?

El script datos.sh está diseñado como un recolector automatizado de telemetría para servidores Linux, específicamente en entornos Debian 12. Su objetivo principal es generar un archivo datos.json que consolide información clave del sistema operativo en tiempo real, para ser consumido por interfaces web o módulos de análisis.

Recolecta datos clave del sistema (CPU, RAM, disco, uptime, procesos).

Evalúa el estado del servidor según el uso de CPU/RAM (MODERADO, ALTO, CRÍTICO).

Obtiene datos del host como el sistema operativo, kernel, arquitectura.

Calcula la carga promedio y cuenta de procesos activos.

Lista los 5 procesos más demandantes por CPU.

Genera un archivo JSON que será visualizado por el panel web.

## 🛠️ Instalación y uso

### 1. Actualizar paquetes, instalar herramientas necesarias (con usuario root)
apt update && apt install git -y

apt install apache2 php bc coreutils procps -y

### 2. Clonar el repositorio, ingresar a ese directorio y crear la ruta del directorio

git clone https://github.com/Chelo2025/Proyecto-MORE

cd Proyecto-MORE

mkdir -p /opt/more/

### 3. Asignar permisos de ejecución

chmod +x datos.sh

### 4. Copiar el script al sistema

cp datos.sh /opt/more/

cp index.php /var/www/html/

cp more.service /etc/systemd/system/

cp more.timer /etc/systemd/system/

### 5. Configuración del administrador systemd (seguimos con usuario root)

systemctl daemon-reexec

systemctl enable --now more.timer


### 6. Ver en el navegador web

http://localhost/index.php


## 👨‍💻 Autor

### Marcelo Martinez - Chelo2025

🎓 Estudiante de Licenciatura en Tecnologías Digitales

🛡️ Técnico Superior en Redes Informáticas

🎓 Estudiante en Diplomado en Administración de Redes Linux, Ciberseguridad y Hacking Ético

🔗 GitHub: https://github.com/Chelo2025