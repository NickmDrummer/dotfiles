#!/bin/bash

# Obtener la lista de IDs de ventanas
windows=$(hyprctl clients -j | jq -r '.[].address')

# Obtener la ventana actualmente enfocada
current=$(hyprctl activewindow -j | jq -r '.address')

# Convertir la lista de ventanas en un array
window_array=($windows)

# Encontrar el índice de la ventana actual
for i in "${!window_array[@]}"; do
  if [[ "${window_array[$i]}" == "$current" ]]; then
    current_index=$i
    break
  fi
done

# Determinar la dirección (next o prev)
direction=$1

# Calcular el índice de la siguiente o anterior ventana
if [[ "$direction" == "next" ]]; then
  next_index=$(((current_index + 1) % ${#window_array[@]}))
else
  next_index=$(((current_index - 1 + ${#window_array[@]}) % ${#window_array[@]}))
fi

# Enfocar la ventana seleccionada
hyprctl dispatch focuswindow address:${window_array[$next_index]}
