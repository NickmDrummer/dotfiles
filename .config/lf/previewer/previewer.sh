#!/bin/sh
draw() {
  # Clear stale Kitty Graphics Protocol placements before drawing.
  printf '\033_Ga=d,d=A\033\\' >/dev/tty
  kitten icat --stdin no --transfer-mode memory --place "${w}x${h}@${x}x${y}" "$1" </dev/null >/dev/tty
  # Non-zero disables lf's preview cache so cleaner runs on every change.
  exit 1
}

file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

case "$(file -Lb --mime-type "$file")" in
image/*)
  draw "$file"
  ;;
video/*)
  # vidthumb is from here:
  # https://raw.githubusercontent.com/duganchen/kitty-pistol-previewer/main/vidthumb
  draw "$(vidthumb "$file")"
  ;;
application/pdf)
  cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/lf"
  mkdir -p "$cache_dir"
  cache_img="$cache_dir/pdf_preview.jpg"
  pdftoppm -jpeg -f 1 -l 1 -singlefile "$file" "${cache_img%.jpg}" >/dev/null 2>&1
  if [ -f "$cache_img" ]; then
    draw "$cache_img"
  fi
  ;;
esac

pistol "$file"
# Disable lf preview caching for text/code/PDF fallbacks too.
exit 1