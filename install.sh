#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <hewittsamuel@gmail.com>
#
# Description:
#   An installation bash script for Paper Icon Theme
#
# Legal Stuff:
#
# This file is part of the Paper Icon Theme and is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; version 3.
#
# This file is part of the Paper Icon Theme and is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/lgpl-3.0.txt>

clear
echo '#---------------------------------------------#'
echo '#     Paper Icon Theme Install Script         #'
echo '#---------------------------------------------#'

function continue {
echo ""
read -p "Do you want to continue? (Y)es, (N)o : " INPUT
case $INPUT in
	[Yy]* ) main;;
    [Nn]* ) exit 99;;
    * ) echo; echo "Sorry, try again."; continue;;
esac
}

function main {
if [ "$UID" -eq "$ROOT_UID" ]; then
	if [ -d /usr/share/icons/Paper ]; then
		echo
		read -p "Found an existing installation. Replace it? (Y)es, (N)o : " INPUT
		case $INPUT in
			[Yy]* ) rm -Rf /usr/share/icons/Paper 2>/dev/null;;
			[Nn]* );;
		    * )
		    clear && echo 'Sorry, try again.'
		    main
		    ;;
		esac
	fi
	cp -R ./Paper/ /usr/share/icons/
	chmod -R 755 /usr/share/icons/Paper
	echo "Installation complete!"
	set
elif [ "$UID" -ne "$ROOT_UID" ]; then
	if [ -d $HOME/.local/share/icons/Paper ]; then
		echo
		read -p "Found an existing installation. Replace it? (Y)es, (N)o : " INPUT
		case $INPUT in
			[Yy]* ) rm -Rf "$HOME/.local/share/icons/Paper" 2>/dev/null;;
			[Nn]* );;
		    * )
		    clear && echo 'Sorry, try again.'
		    main
		    ;;
		esac
	fi
	cp -R ./Paper/ $HOME/.local/share/icons/
	echo "Installation complete!"
	set
fi
}

function set {
echo ""
read -p "Do you want to set Paper as desktop theme? (Y)es, (N)o : " INPUT
case $INPUT in
	[Yy]* ) settheme;;
    [Nn]* ) end;;
    * ) echo; echo "Uh oh, invalid response. Please retry."; set;;
esac
}

function settheme {
echo "Setting Paper as desktop Icon theme..."
gsettings set org.gnome.desktop.interface icon-theme "Paper"
echo "Done."
end
}

function end {
	echo "Exiting"
	exit 0
}

ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
	echo
	echo "Paper Icon Theme will be installed in '$HOME/.local/share/icons/Paper'."
	echo "To make them available to all users, run this script as root."
	continue
else
	echo
	echo "Paper Icon Theme will be installed in '/usr/share/icons'"
	echo "It will be available to all users."
	continue
fi