lockscreendir=$HOME/.config/lockscreen

swaylock -i $lockscreendir/lock_image.png \
    --clock \
	--indicator \
	--indicator-radius 170 \
	--indicator-thickness 7 \
    --effect-vignette 0.5:0.5 \
	--ring-color $color0 \
	--key-hl-color $color1 \
    --layout-text-color  $foreground \
    --font "FiraCode NF" \
    --font-size "40" \
    --text-color $color3 \
    --show-keyboard-layout \
    --disable-caps-lock-text \
    --layout-bg-color 00000000 \
    --layout-text-color $foreground \
    --inside-ver-color 00000088 \
    --line-ver-color $color0 \
    --ring-ver-color $color10  \
    --text-ver-color $foreground
