#!/bin/bash
## qdm - tested on Arch Linux x86_64
## https://github.com/idk/qdm#installation
## 03-20-2013 pdq

## should be no need to edit this file

## ensure dialog is installed
if [ -f /usr/bin/dialog ] && [ -f /usr/bin/ogg123 ]; then

    ## path to sound and style files
    wm_path="${HOME}/.qdm/"

    ## style the messagebox
    if [ ! -f "$HOME/.dialogrc" ]; then
        ln -sfn "${wm_path}dialogrc" "$HOME/.dialogrc"
    fi

    ## login sound
    ogg123 -q "${wm_path}voice-system-activated.ogg"

    ## start urxvt daemon
    [ -z "$(pidof urxvtd)" ] && [ -f /usr/bin/urxvtd ] && urxvtd -q -o -f

    ## start clipboard manager
    if [ -f /usr/bin/autocutsel ]; then
        killall -q autocutsel
        autocutsel -fork &
        autocutsel -selection PRIMARY -fork &
    fi

    ## export some variables
    [ -z "$EDITOR" ] && export EDITOR=nano      # if not set default to nano
    [ -z "$BROWSER" ] && export BROWSER=firefox # if not set default to firefox
    [ -f "$HOME/.gtkrc-2.0" ] && export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

    ## truecrypt mounted success file
    if [ -f "/media/truecrypt1/test" ] ; then
        ogg123 -q "${wm_path}desktop-login.ogg"
    fi

    ## dialog menubox
    wm_cmd=(dialog --keep-tite --menu "Select interface:" 22 76 16)
    wm_options=(1 'e17' 
                2 'Awesome Window Manager'
                3 'kde'
                4 'Razor-QT'
                # 5 'Sample'
                11 'Configure'
                666 'Reboot')

    choices=$("${wm_cmd[@]}" "${wm_options[@]}" 2>&1 >/dev/tty)

    ## execute selected option
    for choice in $choices
    do
        case $choice in
            1)
                exec enlightenment_start
                ;;
            2)
                exec awesome >> "$HOME"/.cache/awesome/stdout 2>> "$HOME"/.cache/awesome/stderr
                ;;
            3)
                exec startkde
                ;;
            4)
                exec razor-session
                ;;
            # 5)
            #     exec sample
            #     ;;
            11)
                $EDITOR "${wm_path}qdm.rc"
                ;;
            666) 
                reboot
                ;;
        esac
    done 
else
    echo "Install the packages dialog and ogg123 ... then re-run"
fi

exit 0