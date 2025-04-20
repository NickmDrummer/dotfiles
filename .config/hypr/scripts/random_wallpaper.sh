#!/bin/bash
env >/tmp/shortcut_env.txt

IMAGE_DIR="$HOME/wallpaper"
CURRENT_IMAGE="$HOME/wallpaper/wallpaper.png"
APP_NAME="Wallpaper selector"
SET_WALLPAPER_SCRIPT="$HOME/.config/hypr/scripts/set_wallpaper.sh"
APPLY_WAL_THEME_SCRIPT="$HOME/.config/hypr/scripts/apply_wal_theme.sh"

validate_image_directory() {
  if [ ! -d "$IMAGE_DIR" ]; then
    notify-send -a "$APP_NAME" "Image directory does not exist" "$IMAGE_DIR"
    exit 1
  fi
}

validate_images() {
  if [ "$1" -eq 0 ]; then
    notify-send -a "$APP_NAME" "No images found" "$IMAGE_DIR"
    exit 1
  fi
}

select_random_image() {
  # Verificar si el array de imágenes está vacío
  if [ ${#images[@]} -eq 0 ]; then
    echo "Error: No images available in the array." >&2
    return 1
  fi

  # Si solo hay una imagen, devolverla (no hay opción de randomizar)
  if [ ${#images[@]} -eq 1 ]; then
    echo "${images[0]}"
    return 0
  fi

  # Si CURRENT_IMAGE no existe o no es un archivo, elegir una imagen aleatoria
  if [ ! -f "$CURRENT_IMAGE" ]; then
    echo "${images[$((RANDOM % ${#images[@]}))]}"
    return 0
  fi

  # Crear un array temporal sin la imagen actual
  local temp_images=()
  for img in "${images[@]}"; do
    if [ ! "$img" -ef "$CURRENT_IMAGE" ]; then
      temp_images+=("$img")
    fi
  done

  # Si no hay otras imágenes disponibles, devolver la actual
  if [ ${#temp_images[@]} -eq 0 ]; then
    echo "$CURRENT_IMAGE"
    return 0
  fi

  # Seleccionar una imagen aleatoria del array temporal
  echo "${temp_images[$((RANDOM % ${#temp_images[@]}))]}"
}

set_new_wallpaper() {
  ln -sf "$1" "$CURRENT_IMAGE"
}

restart_environment() {
  if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    . "$SET_WALLPAPER_SCRIPT"
  else
    i3-msg restart
  fi
}

send_notification() {
  notify-send -a "$APP_NAME" "Wallpaper changed" "$random_image" -i "$CURRENT_IMAGE"
}

# apply_wal_theme() {
#   . "$APPLY_WAL_THEME_SCRIPT"
# }

validate_image_directory
images=("$IMAGE_DIR"/*)
validate_images "${#images[@]}"
random_image=$(select_random_image)
set_new_wallpaper "$random_image"
restart_environment
send_notification
apply_wal_theme() {
  echo "Ejecutando apply_wal_theme"
  if [ -f "$APPLY_WAL_THEME_SCRIPT" ] && [ -x "$APPLY_WAL_THEME_SCRIPT" ]; then
    echo "Ejecutando $APPLY_WAL_THEME_SCRIPT"
    if bash "$APPLY_WAL_THEME_SCRIPT"; then
      echo "apply_wal_theme.sh ejecutado con éxito"
    else
      notify-send -a "$APP_NAME" "Error" "Failed to execute $APPLY_WAL_THEME_SCRIPT"
      echo "Error al ejecutar $APPLY_WAL_THEME_SCRIPT"
      exit 1
    fi
  else
    notify-send -a "$APP_NAME" "Error" "Cannot execute $APPLY_WAL_THEME_SCRIPT"
    echo "No se puede ejecutar $APPLY_WAL_THEME_SCRIPT"
    exit 1
  fi
}
apply_wal_theme
