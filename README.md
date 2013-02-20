qdm
===

quick display manager for gnu/linux
![alt text](https://dl.dropbox.com/u/9702684/022031.png "qdm")

Installation
============

`Non-Archlinux`

	git clone git@github.com:idk/qdm.git
    cp -r qdm ~/.config/

`Archlinux`

	wget https://raw.github.com/idk/qdm/master/PKGBUILD -O /tmp/PKGBUILD && cd /tmp && makepkg -sf PKGBUILD && sudo pacman -U qdm-* && cd && /usr/bin/qdm

Configuration
=============

Backup your ~/.xinitrc

	cp ~/.xinitrc ~/.xinitrc.bak

Edit current ~/.xinitrc or create new file and make it exectuable, add the following code:

    #!/bin/bash
    [ -r "$HOME/.qdm/qdm.sh" ] && . "$HOME/.qdm/qdm.sh"
    # end of file

Test Usage
==========

In terminal/tty run:

	/usr/bin/qdm

Actual Usage
============

Login to tty/virtual console and run:

    xinit


Check out https://www.linuxdistrocommunity.com