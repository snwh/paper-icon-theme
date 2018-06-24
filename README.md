Paper Icon Theme
================

Paper is a modern freedesktop icon theme whose design is based around the use of bold colours and simple geometric shapes to compose icons. Each icon has been meticulously designed for pixel-perfect viewing.

While it does take some inspiration from the icons in Google's Material Design, some aspects have been adjusted to better suit a desktop environment.

## Copying or Reusing

This project has mixed licencing. You are free to copy, redistribute and/or modify aspects of this work under the terms of each licence accordingly (unless otherwise specified).

The Moka icon assets (any and all source `.svg` files or rendered `.png` files) are licenced under the terms of the [Creative Commons Attribution-ShareAlike 4.0 License](https://creativecommons.org/licenses/by-sa/4.0/).

Included scripts are free software licenced under the terms of the [GNU General Public License, version 3](https://www.gnu.org/licenses/gpl-3.0.txt).

When reusing this work please include a proper attribution:

> "[Paper Icons](http://snwh.org/paper/icons)" by [Sam Hewitt](http://samuelhewitt.com/) is licensed under [CC-SA-4.0](http://creativecommons.org/licenses/by-sa/4.0/)

## Downloading Paper

Download instructions for all sorts of systems are available [here](https://snwh.org/paper/download).

## Installing & Using

You can build and install Paper from source using Meson.

```bash
# build
meson "build" --prefix=/usr
# install
sudo ninja -C "build" install
```

By default it installs to `/usr/` but you can specify a different directory with a prefix like: `/usr/local` or `$HOME/.local`.

After which you should be able to pick Paper as your icon or cursor theme in GNOME Tweak tool, or you can set either from a terminal with:

```bash
# set the icon theme
gsettings set org.gnome.desktop.interface icon-theme "Paper"
# or the cursor theme
gsettings set org.gnome.desktop.interface cursor-theme "Paper"
```

### Uninstalling Paper

To uninstall Paper, simply run the following. (If you installed it without superuser priveleges just omit the  `sudo`.)

```bash
sudo ninja -C "build" uninstall
```

Once uninstalled you can reset your icon and cursor theme to the default setting by running the following.

```bash
# reset icon theme to default
gsettings reset org.gnome.desktop.interface icon-theme
# reset cursor theme to default
gsettings reset org.gnome.desktop.interface cursor-theme
```

## Missing Icons & Requests

You can file an icon request as a [GitHub issue](https://github.com/snwh/paper-icon-theme/issues/new). Filing an icon request or reporting a missing icon, please take care in providing the following useful information: 

 - A screenshot of your issue or an image of the original icon you are requesting to be themed
 - The file name for the missing icon or the requested icon, for example `gimp.png` or `system-shutdown.svg`
 - A short description of the application or software that you are requesting an icon for.

Note: some software ships hardcoded icons, meaning when you install icons are not placed in the system-wide directory `/usr/share/icons` which makes them unthemeable.

## Donate & Support

If you would like to support development by making a donation you can do so [here](https://snwh.org/donate) or by becoming a supporter on [Patreon](http://patreon.com/snwh/) or [Liberapay](http://liberapay.com/snwh/). &#x1F60A;