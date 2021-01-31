#!/bin/sh

trap cleanup 1 2 3 6

cleanup() {
# we would like to shutdown everything gracefully in the right order
    pkill kodi
    pkill fluxbox
    pkill Xvnc
}

vncserver $DISPLAY -noxstartup \
                   -securitytypes none \
                   -geometry 1600x900 \
                   -depth 24 \
                   -alwaysshared &
                   

sleep 3
startfluxbox -display $DISPLAY > /dev/null 2>&1 &
kodi-standalone
