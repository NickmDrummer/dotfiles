#!/usr/bin/env bash

# Delete all Kitty Graphics Protocol images from the terminal.
printf '\033_Ga=d,d=A\033\\' >/dev/tty
