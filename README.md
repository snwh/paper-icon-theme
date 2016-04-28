Paper Icon Theme
================

Paper is simple and modern freedesktop icon theme with some material design influences

Paper is a free culture icon theme and is licenced under the terms of the [Creative Commons 
Attribution-ShareAlike](https://creativecommons.org/licenses/by-sa/4.0/), unless otherwise specified.

Software that is part of the Paper Icon Theme source is free software; you can redistribute it and/or modify it under the terms of the [GNU Lesser General Public License](https://www.gnu.org/licenses/lgpl-3.0.txt)

###Building Paper

You can build and install the Paper icon themes from source:

    ./autogen.sh
    make
    sudo make install

This procedure requires ```autotools``` on your system.

###Installing Paper

Alternatively you may install Paper with the provided installation script:

    ./install-icon-theme.sh
    
##Missing Icons & Requests

When filing an icon request or reporting a missing icon, please take care in providing the following useful information: 

 - A screenshot of your issue or an image of the original icon you are requesting to be themed
 - The file name for the missing icon or the requested icon, for example `gimp.png` or `system-shutdown.svg`
 - A short description of the application or software that you are requesting an icon for.

Note: some software does ship their icons in a hardcoded state, meaning when you install it their icons are not place in the system-wide directory `/usr/share/icons` which makes them unthemeable.
