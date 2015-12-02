#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <sam@snwh.org>
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

tabs 4
clear
echo '#-----------------------------------------#'
echo '#     Paper Icon Theme Install Script     #'
echo '#-----------------------------------------#'


show_question() {
echo -e "\033[1;34m$@\033[0m"
}

show_info() {
echo -e "\033[1;33m$@\033[0m"
}

show_success() {
echo -e "\033[1;32m$@\033[0m"
}

show_error() {
echo -e "\033[1;31m$@\033[m" 1>&2
}

function continue {
echo
show_question '\tDo you want to continue? (Y)es, (N)o : ' 
echo
read INPUT
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
		show_question '\tFound an existing installation. Replace it? (Y)es, (N)o : ' 
		echo
		read INPUT
		case $INPUT in
			[Yy]* ) rm -Rf /usr/share/icons/Paper 2>/dev/null;;
			[Nn]* );;
		    * ) show_error '\tSorry, try again.'; main;;
		esac
	fi
	echo "Installing..."
	cp -RH ./Paper/ /usr/share/icons/
	chmod -R 755 /usr/share/icons/Paper
	show_success "Installation complete!"
	echo
	echo "You will have to set your theme manually."
	end
elif [ "$UID" -ne "$ROOT_UID" ]; then
	if [ -d $HOME/.local/share/icons/Paper ]; then
		echo
		show_question '\tFound an existing installation. Replace it? (Y)es, (N)o : ' 
		echo
		read INPUT
		case $INPUT in
			[Yy]* ) rm -Rf "$HOME/.local/share/icons/Paper" 2>/dev/null;;
			[Nn]* );;
		    * ) show_error '\tSorry, try again.'; main;;
		esac
	fi
	echo "Installing..."
	# .local/share/icons
	if [ -d $HOME/.local/share/icons ]; then
		cp -RH ./Paper/ $HOME/.local/share/icons/
	else
		mkdir -p $HOME/.local/share/icons
		cp -RH ./Paper/ $HOME/.local/share/icons/
	fi
	show_success "Installation complete!"
	echo
	useicons
fi
}


function useicons {
echo
show_question '\tDo you want to set Paper as your icon theme? (Y)es, (N)o : ' 
echo
read INPUT
case $INPUT in
	[Yy]* ) 
		echo "Setting Paper as desktop icon theme..."
		gsettings reset org.gnome.desktop.interface icon-theme
		gsettings set org.gnome.desktop.interface icon-theme "Paper"
		show_success "Complete."
		usecursors
		;;
    [Nn]* ) usecursors;;
    * ) echo; show_error "\aUh oh, invalid response. Please retry."; useicons;;
esac
}

function usecursors {
echo
show_question '\tDo you want to set Paper as your cursor theme? (Y)es, (N)o : ' 
echo
read INPUT
case $INPUT in
	[Yy]* )
		echo "Setting Paper as desktop cursor theme..."
		gsettings reset org.gnome.desktop.interface cursor-theme
		gsettings set org.gnome.desktop.interface cursor-theme "Paper"
		show_success "Complete."
		show_info "You may need to log out & back in for the cursor change to take effect."
		end
		;;
    [Nn]* ) end;;
    * ) echo; show_error "\aUh oh, invalid response. Please retry."; usecursors;;
esac
}

function end {
	echo
	show_info "\tAll done. Press any key to exit."
	echo
	read -n1
	exit 0
}

ROOT_UID=0
if [ "$UID" -ne "$ROOT_UID" ]; then
	echo
	echo "Paper will be installed in your home directory:"
	echo
	show_info '\t$HOME/.local/share/icons'
	echo
	echo "To make them available to all users, run this script as root."
	continue
else
	echo
	echo "Paper will be installed in for system-wide use:"
	echo
	show_info '\t/usr/share/icons'
	echo
	echo "It will be available to all users."
	continue
fi