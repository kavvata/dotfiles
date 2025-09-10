#!/bin/env bash
killall waybar
waybar --config /home/kav/.config/waybar/niri-config.json & disown
