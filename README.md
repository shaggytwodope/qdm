qdm
===

quick display manager for gnu/linux

Installation
============

    git clone git@github.com:idk/qdm.git
    cp qdm ~/.qdm

Usage
=====

Edit your ~/.xinitrc to the following:

    #!/bin/bash
    [ -r "$HOME/.qdm/qdm.sh" ] && . "$HOME/.qdm/qdm.sh"
    # end of file
