#!/bin/bash

# Nombre del sink
SINK_NAME="alsa_output.pci-0000_0c_00.6.analog-stereo"

# Puertos disponibles
PORT_HEADPHONES="analog-output-headphones"
PORT_LINEOUT="analog-output-lineout"
PORT_HEADPHONES_NAME="PARLANTES"
PORT_LINEOUT_NAME="AURICULARES"

# Archivo para almacenar el puerto actual
STATE_FILE="$HOME/.cache/current_audio_port"

# Leer el puerto actual del archivo de estado, o usar auriculares por defecto
if [ -f "$STATE_FILE" ]; then
  CURRENT_PORT=$(cat "$STATE_FILE")
else
  CURRENT_PORT="$PORT_HEADPHONES"
fi

# Debugging: Mostrar el puerto actual asumido
echo "Puerto actual asumido (de state file): $CURRENT_PORT" >&2

# Determinar el próximo puerto
if [ "$CURRENT_PORT" = "$PORT_HEADPHONES" ]; then
  NEXT_PORT="$PORT_LINEOUT"
  NEXT_PORT_NAME="$PORT_LINEOUT_NAME"
else
  NEXT_PORT="$PORT_HEADPHONES"
  NEXT_PORT_NAME="$PORT_HEADPHONES_NAME"
fi

# Debugging: Mostrar el puerto al que intentamos cambiar
echo "Intentando cambiar a: $NEXT_PORT" >&2

# Cambiar al próximo puerto
pactl set-sink-port "$SINK_NAME" "$NEXT_PORT"

# Debugging: Mostrar la salida completa de pactl para el sink
echo "Salida de pactl list sinks para el sink:" >&2
pactl list sinks | grep -A 100 "Name: $SINK_NAME" | grep "Active Port" >&2

# Guardar el nuevo puerto en el archivo de estado
echo "$NEXT_PORT" >"$STATE_FILE"

# Mostrar notificación
notify-send "Salida de audio cambiada" "$NEXT_PORT_NAME" -t 2000
echo "Cambiado exitosamente a: $NEXT_PORT_NAME" >&2
