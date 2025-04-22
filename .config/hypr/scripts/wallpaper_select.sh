#!/bin/bash

image_dir="$HOME/wallpaper/"
images=("$image_dir"/*)
APPLY_NEW_BORDERS_SCRIPT="$HOME/.config/hypr/scripts/RainbowBorders.sh"

apply_new_borders() {
  if [ -f "$APPLY_NEW_BORDERS_SCRIPT" ] && [ -x "$APPLY_NEW_BORDERS_SCRIPT" ]; then
    echo "Ejecutando $APPLY_NEW_BORDERS_SCRIPT"
    if "$APPLY_NEW_BORDERS_SCRIPT"; then
      echo "apply_new_borders.sh ejecutado con éxito"
    else
      notify-send -a "$APP_NAME" "Error" "Failed to execute $APPLY_NEW_BORDERS_SCRIPT"
      echo "Error al ejecutar $APPLY_NEW_BORDERS_SCRIPT"
      exit 1
    fi
  else
    notify-send -a "$APP_NAME" "Error" "Cannot execute $APPLY_NEW_BORDERS_SCRIPT"
    echo "No se puede ejecutar $APPLY_NEW_BORDERS_SCRIPT"
    exit 1
  fi
}
image_list=""
for img in "${images[@]}"; do
  image_list+=$(basename "$img" | cut -d. -f1)"\x00icon\x1f${img}\n"
done

selected_image=$(printf '%b' "$image_list" | rofi -dmenu -theme ~/.config/rofi/wallpaper-select.rasi -p "Select wallpaper")

for img in "${images[@]}"; do
  if [[ "$(basename "$img" | cut -d. -f1)" = "$selected_image" ]]; then
    selected_image_path="$img"
    break
  fi
done

if [ -n "$selected_image_path" ]; then
  ln -sf "$selected_image_path" ~/wallpaper/wallpaper.png

  if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    . ~/.config/hypr/scripts/set_wallpaper.sh
  else
    i3-msg restart
  fi

  notify-send -a "Wallpaper selector" "Wallpaper changed" "$selected_image_path" -i ~/wallpaper/wallpaper.png
  . ~/.config/hypr/scripts/apply_wal_theme.sh
  apply_new_borders
fi
