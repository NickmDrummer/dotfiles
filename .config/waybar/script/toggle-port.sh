#!/bin/bash

SINK_NAME="alsa_output.pci-0000_0c_00.6.analog-stereo"

PORT_HEADPHONES="analog-output-headphones"
PORT_LINEOUT="analog-output-lineout"
PORT_HEADPHONES_NAME="SPEAKERS"
PORT_LINEOUT_NAME="HEADPHONES"

# File to store the current port
STATE_FILE="$HOME/.cache/current_audio_port"

if [ -f "$STATE_FILE" ]; then
  CURRENT_PORT=$(cat "$STATE_FILE")
else
  CURRENT_PORT="$PORT_HEADPHONES"
fi

# Debugging:
echo "Current Port (from state file): $CURRENT_PORT" >&2

# Determine the next port to use
if [ "$CURRENT_PORT" = "$PORT_HEADPHONES" ]; then
  NEXT_PORT="$PORT_LINEOUT"
  NEXT_PORT_NAME="$PORT_LINEOUT_NAME"
else
  NEXT_PORT="$PORT_HEADPHONES"
  NEXT_PORT_NAME="$PORT_HEADPHONES_NAME"
fi

# Debugging: show the port to change
echo "Trying to change to $NEXT_PORT" >&2

# Change to the next port
pactl set-sink-port "$SINK_NAME" "$NEXT_PORT"

# Debugging: Show the complete output from pactl
echo "pactl list sinks:" >&2
pactl list sinks | grep -A 100 "Name: $SINK_NAME" | grep "Active Port" >&2

# Save the new port in the state's file
echo "$NEXT_PORT" >"$STATE_FILE"

# Notify the user
notify-send "Audio Output Changed" "$NEXT_PORT_NAME" -t 2000
echo "Cambiado exitosamente a: $NEXT_PORT_NAME" >&2
