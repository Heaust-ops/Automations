#!/bin/sh

# This dynamically maps my 2 extra mouse buttons
# to the application I'm currently using
# Once started it won't need to be touched again
# It will automatically detect if a new window is selected and remap the buttons for it
# I have it in my home directory an have an alias set for the below command to execute it
# sudo -b nohup /home/heaust/dynmap.sh && exit
# This throws the process in the background and exits terminal
# So you don't have to have an extra terminal open at all times
# you can get names to use for keys from xbindkeys-config

# Exit if another instance of the Script is already running
[ "$(pgrep -x $(basename $0))" != "$$" ] && exit 1

# USING XBINDKEYS TO MAP KEYS, THIS IS WHERE MAPPINGS ARE STORED
file=".xbindkeysrc"

window_prev=""

while [ true ]
do
    sleep 0.1
    window=`xdotool getwindowfocus getwindowname`
    case $window in

        # IF WE'RE IN TERMINAL
        *"heaust@Canvas"*)
            echo "\"xte 'keydown Control_L' 'keydown Shift_L' 'keydown c' 'keyup c' 'keyup Shift_L' 'keyup Control_L'\"
    b:8 + Release

\"xte 'keydown Control_L' 'keydown Shift_L' 'keydown v' 'keyup v' 'keyup Shift_L' 'keyup Control_L'\"
    b:9 + Release

\"xte 'keydown Control_L' 'keydown alt' 'keydown t' 'keyup t' 'keyup alt' 'keyup Control_L'\"
    alt + b:8 + Release" > $file
            ;;
        # IF WE'RE IN KRITA
        *"Krita"*|*"Blender"*)
            echo "\"xte 'keydown Control_L' 'keydown z' 'keyup z' 'keyup Control_L'\"
    b:8 + Release

\"xte 'keydown Control_L' 'keydown Shift_L' 'keydown z' 'keyup z' 'keyup Shift_L' 'keyup Control_L'\"
    b:9 + Release

\"xte 'keydown Control_L' 'keydown alt' 'keydown t' 'keyup t' 'keyup alt' 'keyup Control_L'\"
    alt + b:8 + Release" > $file
            ;;

        # BY DEFAULT        
        *)
            echo "\"xte 'keydown Control_L' 'keydown c' 'keyup c' 'keyup Control_L'\"
    b:8 + Release

\"xte 'keydown Control_L' 'keydown v' 'keyup v' 'keyup Control_L'\"
    b:9 + Release

\"xte 'keydown Control_L' 'keydown alt' 'keydown t' 'keyup t' 'keyup alt' 'keyup Control_L'\"
    alt + b:8 + Release" > $file
            ;;
    esac
    if [ "$window_prev" != "$window" ]; then
        killall -HUP xbindkeys
    fi

    window_prev=$window
done
