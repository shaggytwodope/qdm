qdm
===

quick display manager for gnu/linux
![alt text](https://dl.dropbox.com/u/9702684/022031.png "qdm")

Installation
============

    git clone git@github.com:idk/qdm.git
    cp -r qdm ~/.qdm

Configuration
=============

Backup your ~/.xinitrc

	cp ~/.xinitrc ~/.xinitrc.bak

Edit current ~/.xinitrc or create new file and make it exectuable, add the following code:

    #!/bin/bash
    [ -r "$HOME/.qdm/qdm.sh" ] && . "$HOME/.qdm/qdm.sh"
    # end of file

Usage
=====

Login to tty/virtual console and run the command:

    xinit