#!/bin/bash
## qdm - tested on Arch Linux x86_64
## https://github.com/idk/qdm#installation
## 03-20-2013 pdq

USE_SOUNDS=0 # 1 = on, 0 = off

# power options
_power_off="poweroff"
_reboot="reboot"


## should be little need to edit the file
## but you always do what you want to do anyways, right?


qdm() {
    [ ! -f /usr/bin/ogg123 ] && [ $USE_SOUNDS = 1 ] && echo "Install vorbis-tools (ogg123) for sounds" && exit 0

    ## ensure dialog is installed
    if [ -f /usr/bin/dialog ]; then

        ## path qdm files
        wm_path="${HOME}/.qdm/"

        ## style the messagebox
        if [ ! -f "$HOME/.dialogrc" ]; then
            ln -sfn "${wm_path}dialogrc" "$HOME/.dialogrc"
        fi

        echo "loading quick display manager..."

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
        wm_cmd=(dialog --backtitle "quick display manager" --title "qdm" --menu "Select interface:" 22 76 16)
        wm_options=(1 'e17' 
                    2 'Awesome Window Manager'
                    3 'kde'
                    4 'Razor-QT'
                    5 'xfce'
                    # 6 'Sample'
                    11 'Configure'
                    666 'Power options')

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
                11) wm_configure && qdm;;
                666) wm_power;;
            esac
        done
    fi
}

wm_configure() {
    conf_dialog=(dialog --backtitle "quick display manager" --title "qdm" --menu "Select file to edit in $EDITOR:" 22 76 16)
    conf_options=(1 'Edit script (~/.qdm/qdm.sh)' 
                  2 'Edit colors (~/.dialogrc)')

    conf_choices=$("${conf_dialog[@]}" "${conf_options[@]}" 2>&1 >/dev/tty)

    for choice in $conf_choices
    do
        case $choice in
            1) $EDITOR "${wm_path}qdm.sh";;
            2) $EDITOR "${HOME}/.dialogrc";;
        esac
    done
}

wm_power() {
      power_dialog=(dialog --clear --backtitle "quick display manager" --title "qdm" --menu "Power options" 20 70 16)
      power_options=(1 'Reboot' 
                     2 'Power off'
                     3 'Return to qdm')

    power_choices=$("${power_dialog[@]}" "${power_options[@]}" 2>&1 >/dev/tty)

    for choice in $power_choices
    do
        case $choice in
            1) dialog --clear --backtitle "quick display manager" --title "qdm" --yesno "Reboot, really?" 10 30 && [ $? = 0 ] && echo "$_reboot" && exit 0;;
            2) dialog --clear --backtitle "quick display manager" --title "qdm" --yesno "Power off, really?" 10 30 && [ $? = 0 ] && echo "$_power_off" && exit 0;;
            # 3) echo "re-loading quick display manager..." && qdm;;
            3) qdm;;
        esac
    done

    qdm
}

qdm
exit 0