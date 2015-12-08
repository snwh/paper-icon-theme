#!/bin/sh

set -e

autoreconf --force --install --symlink --warnings=all

if test -z "${NOCONFIGURE}"; then
    set -x
    ./configure --prefix=/usr "$@"
    make clean
fi