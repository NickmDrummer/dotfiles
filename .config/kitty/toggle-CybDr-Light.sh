#!/bin/bash
kitty @ set-colors ~/.config/kitty/themes/cyberdream-light.conf
kitty @ send-text --match=title:vi ":CyberdreamToggleMode\r"
