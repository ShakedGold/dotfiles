#!/bin/bash

#theme elements
dir="$HOME/.config/rofi.shaked/shared/styles"
theme='style-screenshot'

prompt="Screenshot"
screenshot_dir=$HOME/Pictures/Screenshots
msg="DIR: $screenshot_dir"

#create screenshot dir and skip if exists
mkdir $screenshot_dir 2> /dev/null

rofi_cmd() {
	rofi \
        -dmenu \
        -theme ${dir}/${theme}.rasi \
		-p "$prompt" \
		-mesg "$msg" \
        -theme-str 'textbox-prompt-colon {str: "";}' \
        -markup-rows \
        -hover-select -me-select-entry '' -me-accept-entry MousePrimary
}

run_rofi() {
    echo "$*" | tr ' ' '\n' | rofi_cmd
}

time=$(date +%Y-%m-%d-%H-%M-%S)
geometry=$(xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current')

file="Screenshot_${time}_${geometry}"
screenshot_file="$screenshot_dir/$file"


screenshot() {
    hyprshot -m $1 -f $file -o $screenshot_dir
}
screenshot_copy() {
    hyprshot -m $1 -f $file -o $screenshot_dir -s
    notify-send -i $screenshot_file "Screenshot Copied" "Screenshot copied to clipboard"
    rm $screenshot_file
}

options=("region" "window" "monitor")
icons=("" "" "")

clipboard=$(run_rofi "" "")
if [[ $clipboard == "" ]]; then exit; fi

chosen=$(run_rofi ${icons[*]})
if [[ $chosen == "" ]]; then exit; fi

case $chosen in
    "") chosen="region";;
    "") chosen="window";;
    "") chosen="output";;
esac

if [[ $clipboard == "" ]]; then #clipboard
    screenshot_copy $chosen
else #file
    screenshot $chosen
fi
