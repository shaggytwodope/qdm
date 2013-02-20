#!/bin/bash
## qdm - tested on Arch Linux x86_64
## https://github.com/idk/qdm#installation
## 03-20-2013 pdq

USE_SOUNDS=1 # 1 = on, 2 = off

## should be little need to edit the file, but you always do what you want to do anyways, right?
qdm() {
    [ ! -f /usr/bin/ogg123 ] && [ $USE_SOUNDS = 1 ] && echo "Install vorbis-tools (ogg123) for sounds" && exit 0

    ## ensure dialog is installed
    if [ -f /usr/bin/dialog ]; then

        ## path qdm files
        wm_path="${HOME}/.qdm/"

        ## temporary files
        mkdir -p /tmp/tmp 2>/dev/null
        _TMP=/tmp/tmp 2>/dev/null

        ## style the messagebox
        if [ ! -f "$HOME/.dialogrc" ]; then
            ln -sfn "${wm_path}dialogrc" "$HOME/.dialogrc"
        fi

        ## login sound
        [ $USE_SOUNDS = 1 ] && ogg123 -q "${wm_path}voice-system-activated.ogg"

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
        if [ $USE_SOUNDS = 1 ] && [ -f "/media/truecrypt1/test" ] ; then
            ogg123 -q "${wm_path}desktop-login.ogg"
        fi

        ## dialog menubox
        wm_cmd=(dialog --keep-tite --menu "Select interface:" 22 76 16)
        wm_options=(1 'e17' 
                    2 'Awesome Window Manager'
                    3 'kde'
                    4 'Razor-QT'
                    5 'xfce'
                    # 6 'Sample'
                    11 'Configure'
                    666 'Reboot')

        choices=$("${wm_cmd[@]}" "${wm_options[@]}" 2>&1 >/dev/tty)

        ## execute selected option
        for choice in $choices
        do
            case $choice in
                1) exec enlightenment_start;;
                2) exec awesome >> "$HOME"/.cache/awesome/stdout 2>> "$HOME"/.cache/awesome/stderr;;
                3) exec startkde;;
                4) exec razor-session;;
                5) exec startxfce4;;
                # 6) exec sample;;
                11) wm_configure && echo "re-loading quick display manager..." && qdm;;
                666) reboot;;
            esac
        done

    else
        echo "Install the package dialog... then re-run"
    fi
}

wm_configure() {
    conf_dialog=(dialog --keep-tite --menu "Select file to edit in $EDITOR:" 22 76 16)
    conf_options=(1 'Edit script (~/.qdm/qdm.sh)' 
                  2 'Edit colors (~/.dialogrc)')

    conf_choices=$("${conf_dialog[@]}" "${conf_options[@]}" 2>&1 >/dev/tty)

    ## execute selected option
    for choice in $conf_choices
    do
        case $choice in
            1) $EDITOR "${wm_path}qdm.sh";;
            2) $EDITOR "${HOME}/.dialogrc";;
        esac
    done
}

qdm
exit 0