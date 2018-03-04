#!/bin/sh

set -e

test -n "$srcdir" || srcdir=`dirname "$0"`
test -n "$srcdir" || srcdir=.

olddir=`pwd`
cd "$srcdir"

autoreconf --force --install --symlink --warnings=all

if test -z "${NOCONFIGURE}"; then
    set -x
    ./configure --prefix=/usr "$@"
    make clean
fi

cd "$olddir"
