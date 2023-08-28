#! /bin/bash

#default arguments
dim_level=20
blur_level=1
pixel_scale=10,1000

while getopts b:d:p: name
do
    case $name in
    d)  dim_level=$OPTARG;;
    b)  blur_level=$OPTARG;;
    p) pixel_scale=$OPTARG;;
    ?)  printf "Usage: %s: [-b value] [-d value] args\n" $0
            exit 2;;
    esac
done

#fx
dim() {
    local input="$1"
    local output="$2"

    echof act "Rendering 'dim' effect..."
    convert "$input" \
        -fill black -colorize "$dim_level"% \
        "$output"
}
blur() {
    local input="$1"
    local output="$2"
    
    echof act "Rendering 'blur' effect..."
    blur_shrink=$(echo "scale=2; 20 / $blur_level" | bc)
    blur_sigma=$(echo "scale=2; 0.6 * $blur_level" | bc)
    convert "$input" \
        -filter Gaussian \
        -resize "$blur_shrink%" \
        -define "filter:sigma=$blur_sigma" \
        -resize "1920x1080^" -gravity center -extent "1920x1080" \
        "$output"
}



echof() {

    local prefix="$1"
    local message="$2"

    case "$prefix" in
        header) msgpfx="[\e[1;95mB\e[m]";;
        info) msgpfx="[\e[1;97m=\e[m]";;
        act) msgpfx="[\e[1;92m*\e[m]";;
        ok) msgpfx="[\e[1;93m+\e[m]";;
        error) msgpfx="[\e[1;91m!\e[m]";;
        *) msgpfx="";;
    esac
    [ "$quiet" != true ] && echo -e "$msgpfx $message"
}

#pywal color dir
waldir="$HOME/.cache/wal"
#lockscreen dir
lockscreendir="$HOME/.config/lockscreen"

fx_list=(dim blur)

# get wallpaper image
wallpaper=$(cat $waldir/wal)
image=$lockscreendir/$(basename $wallpaper)
cp $wallpaper $lockscreendir

out_image=$lockscreendir/"lock_image.png"

for effect in "${fx_list[@]}"; do
        case $effect in
            dim) dim $image $out_image;;
            blur) blur $image $out_image;;
        esac
done

rm $image
cp $waldir/colors.sh $lockscreendir

$lockscreendir/update_lockscreen.sh
