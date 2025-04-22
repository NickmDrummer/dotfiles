#!/bin/bash

# Verifica si wf-recorder está en ejecución
if pgrep -x wf-recorder >/dev/null; then
  # Obtiene el PID de wf-recorder
  pid=$(pgrep -x wf-recorder)
  # Obtiene el tiempo de inicio del proceso (en segundos desde epoch)
  start_time=$(ps -p "$pid" -o lstart=)
  # Convierte el tiempo de inicio a segundos desde epoch
  start_epoch=$(date -d "$start_time" +%s)
  # Obtiene el tiempo actual en segundos desde epoch
  current_epoch=$(date +%s)
  # Calcula el tiempo transcurrido en segundos
  elapsed=$((current_epoch - start_epoch))
  # Convierte a formato MM:SS
  minutes=$((elapsed / 60))
  seconds=$((elapsed % 60))
  formatted_time=$(printf "%02d:%02d" $minutes $seconds)
  # Devuelve JSON con icono y tiempo
  echo "{\"text\": \"󰑊   $formatted_time\", \"class\": \"recording\"}"
else
  # Si no está grabando, no muestra nada
  echo "{\"text\": \"\"}"
fi
