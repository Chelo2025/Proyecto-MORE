#!/bin/bash
# 9 de julio - Día de la Independencia de la Argentina
# Script para recopilar datos del sistema y generar un archivo JSON
# Proyecto MORE (Monitoreo, Observación, Registro y Evaluación)
OUT="/opt/more/datos.json"

# CPU
cpu_total=$(top -bn1 | grep "%Cpu" | awk '{print 100 - $8}')
cpu_total_formatted=$(printf "%.1f" "$cpu_total")

# RAM
mem_data=$(free -m | awk '/Mem:/ {print $3, $2}')
mem_used=$(echo "$mem_data" | awk '{print $1}')
mem_total=$(echo "$mem_data" | awk '{print $2}')
mem_percent=$(awk "BEGIN {printf \"%.1f\", ($mem_used/$mem_total)*100}")

# Estado del sistema
estado="MODERADO"
if (( $(echo "$cpu_total > 80.0" | bc -l) )) || (( $(echo "$mem_percent > 85.0" | bc -l) )); then
  estado="CRÍTICO"
elif (( $(echo "$cpu_total > 50.0" | bc -l) )) || (( $(echo "$mem_percent > 60.0" | bc -l) )); then
  estado="ALTO"
fi

# Procesos top por CPU
procesos=$(ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 | tail -n 5 | awk '{printf "{\"pid\":\"%s\",\"cmd\":\"%s\",\"cpu\":\"%s\",\"mem\":\"%s\"},", $1,$2,$3,$4}' | sed 's/,$//')

# Carga promedio y procesos
read carga1 carga5 carga15 procs pidfinal < /proc/loadavg
activos=$(echo $procs | cut -d/ -f1)
total=$(echo $procs | cut -d/ -f2)

# Datos del sistema
fecha=$(date "+%d-%m-%Y %H:%M:%S")
hostname=$(hostname)
kernel=$(uname -r)
arch=$(uname -m)
os=$(hostnamectl | grep "Operating System" | cut -d: -f2- | xargs)
uptime=$(uptime -p)
disco=$(df -h / | awk '$6=="/"{print $3 "/" $2}')
usuarios=$(who | wc -l)

# Generar JSON
cat <<EOF > "$OUT"
{
  "fecha": "$fecha",
  "cpu": "$cpu_total_formatted",
  "ram_usada": "$mem_used",
  "ram_total": "$mem_total",
  "ram_porcentaje": "$mem_percent",
  "disco": "$disco",
  "uptime": "$uptime",
  "usuarios": "$usuarios",
  "carga_1m": "$carga1",
  "carga_5m": "$carga5",
  "carga_15m": "$carga15",
  "procesos_activos": "$activos",
  "procesos_totales": "$total",
  "ultimo_pid": "$pidfinal",
  "estado": "$estado",
  "hostname": "$hostname",
  "os": "$os",
  "kernel": "$kernel",
  "arquitectura": "$arch",
  "procesos": [
    $procesos
  ]
}
EOF
