#!/usr/bin/env bash

#COLORSCHEME=dracula
COLORSCHEME=macchiato

# write your script here
/usr/bin/lxpolkit &
/usr/libexec/xdg-desktop-portal &
/usr/libexec/xdg-desktop-portal-gtk &
/usr/libexec/xdg-desktop-portal-rewrite-launchers &
/usr/libexec/xdg-desktop-portal-validate-icon &
/usr/libexec/xdg-desktop-portal-validate-sound &
dunst -conf "$HOME"/.config/dunst/"$COLORSCHEME" &
lxsession -n -a &
nitrogen --restore &
nm-applet &
picom &
redshift-gtk &
thunar --daemon &
xfce4-power-manager &
xfce4-volumed-pulse &
