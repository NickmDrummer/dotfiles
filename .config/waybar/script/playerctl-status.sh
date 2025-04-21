#!/bin/bash

# Verifica si MPV está activo
if ! playerctl --player=mpv status >/dev/null 2>&1; then
  echo '{"text": "", "tooltip": "", "alt": "", "class": ""}'
  exit 0
fi

# Obtiene estado, artista, título, posición y duración
status=$(playerctl --player=mpv status 2>/dev/null)
artist=$(playerctl --player=mpv metadata artist 2>/dev/null || echo "")
title=$(playerctl --player=mpv metadata title 2>/dev/null || echo "Unknown")
position=$(playerctl --player=mpv metadata --format '{{ duration(position) }}' 2>/dev/null || echo "0:00")
duration=$(playerctl --player=mpv metadata --format '{{ duration(mpris:length) }}' 2>/dev/null || echo "0:00")

short_artist=$(echo "$artist" | awk '{ if (length($0) > 7) print substr($0, 1, 7); else print $0 }')

short_title=$(echo "$title" | awk '{ if (length($0) > 7) print substr($0, 1, 7); else print $0 }')

# Simplifica el formato de posición y duración (elimina ceros iniciales)
short_position=$(echo "$position" | sed 's/^0*://; s/^0*//')
short_duration=$(echo "$duration" | sed 's/^0*://; s/^0*//')

# Construye el texto (artista + título + duración)
if [ -n "$short_artist" ]; then
  text=$(echo "$short_artist - $short_title  $short_position/$short_duration" | sed 's/"/\\"/g')
else
  text=$(echo "$short_title $short_position/$short_duration" | sed 's/"/\\"/g')
fi

# Construye el tooltip con información completa
tooltip=$(echo "MPV: $artist - $clean_title ($position/$duration)" | sed 's/"/\\"/g')
class="$status"

# Genera salida JSON
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"alt\": \"$class\", \"class\": \"$class\", \"position\": \"$position\", \"duration\": \"$duration\"}"
