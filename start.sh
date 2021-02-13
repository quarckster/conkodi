#!/bin/sh
pulseaudio > /dev/null 2>&1 &

vncserver $DISPLAY -noxstartup \
                   -securitytypes none \
                   -geometry 1600x900 \
                   # kodi doesn't start on lower depth values
                   -depth 24 \
                   -alwaysshared > /dev/null 2>&1 &

/usr/lib/x86_64-linux-gnu/kodi/kodi.bin --standalone  > /dev/null 2>&1 &

while [ ! -f ".kodi/temp/kodi.log" ]; do
    sleep 0.1
done

tail -f .kodi/temp/kodi.log
