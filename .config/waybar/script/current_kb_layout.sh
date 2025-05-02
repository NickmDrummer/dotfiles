#!/bin/bash
variant=$(hyprctl getoption input:kb_variant | grep str | awk '{print $2}' | tr -d '"')
if [ -z "$variant" ] || [ "$variant" = "," ] || [ "$variant" = "none" ]; then
  echo '{"text":"🇺🇸"}'
else
  echo '{"text":"🌐"}'
fi
