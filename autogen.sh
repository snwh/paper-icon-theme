#!/bin/sh
# Run this to generate all the initial makefiles, etc.

autoreconf -vfi
./configure --prefix=/usr $*