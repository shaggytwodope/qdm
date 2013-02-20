qdm
===

quick display manager for gnu/linux
![alt text](https://dl.dropbox.com/u/9702684/022031.png "qdm")

Installation
============

    git clone git@github.com:idk/qdm.git
    cp qdm ~/.qdm

Configuration
=============

Edit your ~/.xinitrc to the following:

    #!/bin/bash
    [ -r "$HOME/.qdm/qdm.sh" ] && . "$HOME/.qdm/qdm.sh"
    # end of file

Usage
=====

Login to tty/virtual console and run the command:

    xinit