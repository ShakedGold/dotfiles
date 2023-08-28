#! /bin/bash

#Variables
waldir=$HOME/.cache/wal
hyprdir=$HOME/.config/hypr
waybardir=$HOME/.config/waybar
powermenudir=$HOME/.config/rofi/powermenu/type-3/shared
screenshotdir=$HOME/.config/rofi.shaked/shared/imports
dunstdir=$HOME/.config/dunst

#Pick wallpaper
wal -i $1 -n
wallpaper=$(cat $waldir/wal)

#copy color to change waybar
cp $waldir/colors-waybar.css $waybardir

#set gradient hyprland
source "$waldir/colors.sh"

get_color_value() {
    echo $1 | sed -E 's/#(.*)/\1/g'
}

gradient1="\$gradient1 = $(get_color_value $color10)FF"
gradient2="\$gradient2 = $(get_color_value $color14)FF"
echo -e "$gradient1\n$gradient2" > $hyprdir/hyprcolors.conf

#change wallpaper
echo -ne "preload=$wallpaper\nwallpaper=,$wallpaper" > $hyprdir/hyprpaper.conf

# move wal colors
cp $waldir/colors-rofi-dark.rasi $powermenudir
mv $powermenudir/colors.rasi $powermenudir/colors.rasi.bak
mv $powermenudir/colors-rofi-dark.rasi $powermenudir/colors.rasi

cp $waldir/colors-rofi-dark.rasi $screenshotdir
mv $screenshotdir/colors.rasi $screenshotdir/colors.rasi.bak
mv $screenshotdir/colors-rofi-dark.rasi $screenshotdir/colors.rasi

rofi_colors_change() {
    for folder in $(echo $* | cut -d' ' -f3-$#); do
        file="$folder/colors.rasi"
        sed -Ei "s/($1: )(.*)/\1\2\n$2: \2/" $file
    done
}

#set background-alt
rofi_colors_change alternate-normal-background background-alt $powermenudir $screenshotdir
#set selected
rofi_colors_change selected-normal-background selected $powermenudir $screenshotdir
#set active
rofi_colors_change active-background active $powermenudir $screenshotdir
#set urget
rofi_colors_change urgent-background urgent $powermenudir $screenshotdir

#set dunst colors
DUNST_FILE=$dunstdir/dunstrc

colors=$(grep -E '#' $DUNST_FILE | sed -E 's/#[0-9a-zA-Z]+//' | sed -E 's/.*#(.*)/\1/g' | sed 's/\n/ /g' | tr '\n' ' ')
for c in $(echo $colors); do
    case $c in
        "background") sed -Ei 's/(.* = \").*(\").*(#background)/\1'$background'\2 \3/' $DUNST_FILE
        ;;
        "foreground") sed -Ei 's/(.* = \").*(\").*(#foreground)/\1'$foreground'\2 \3/' $DUNST_FILE
        ;;
        "color1")  sed -Ei 's/(.* = \").*(\").*(#color1)/\1'$color1'\2 \3/' $DUNST_FILE
        ;;
         *) exit
        ;;
    esac
done

# restart services
killall dunst
killall hyprpaper
killall waybar

hyprpaper &>/dev/null &
waybar &>/dev/null &
dunst &>/dev/null &

#set lock wallpaper
$HOME/.config/lockscreen/lock_wallpaper.sh -d "20" -b "2" -p "10,1000"
