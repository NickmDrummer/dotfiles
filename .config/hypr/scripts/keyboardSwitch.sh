#!/bin/bash
current_layout=$(hyprctl getoption input:kb_variant | grep str | awk '{print $2}' | tr -d '"')
if [ "$current_layout" = "intl" ]; then
  hyprctl keyword input:kb_layout us
  hyprctl keyword input:kb_variant ""
  notify-send "Keyboard Layout" "Switched to US"
else
  hyprctl keyword input:kb_layout us
  hyprctl keyword input:kb_variant intl
  notify-send "Keyboard Layout" "Switched to US International"
fi
pkill -SIGRTMIN+1 waybar
