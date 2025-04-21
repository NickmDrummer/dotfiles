#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# for rainbow borders animation

# function random_hex() {
#   random_hex=("0xff$(openssl rand -hex 3)")
#   echo $random_hex
# }

# rainbow colors only for active window
# hyprctl keyword general:col.active_border $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) 270deg

source "$HOME/.cache/wal/colors.sh"

color9="0xff${color9:1}" # Elimina '#' y añade '0xff'
color10="0xff${color10:1}"
color11="0xff${color11:1}"
color12="0xff${color12:1}"
color13="0xff${color13:1}"
color14="0xff${color14:1}"

hyprctl keyword general:col.active_border "$color9" "$color10" "$color11" "$color12" "$color13" "$color14" 270deg
# rainbow colors for inactive window (uncomment to take effect)
#hyprctl keyword general:col.inactive_border $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex)r$(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) 270deg
