#!/bin/bash

[[ -d build ]] && rm -rf build
meson setup build
ninja -C build
./build/rofi -theme ~/.config/awesome/configuration/rofi/appmenu/drun.rasi -show drun
