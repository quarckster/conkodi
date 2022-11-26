#!/bin/sh

Xvnc ${DISPLAY} \
     -alwaysshared \
     -depth 24 \
     -geometry 1600x900 \
     -securitytypes none \
     -auth ${HOME}/.Xauthority \
     -fp catalogue:/etc/X11/fontpath.d \
     -pn \
     -rfbport 5999 2>&1 &

pulseaudio > /dev/null 2>&1 &

kodi --standalone  > /dev/null 2>&1 &

while [ ! -f ".kodi/temp/kodi.log" ]; do
    sleep 0.1
done

tail -f .kodi/temp/kodi.log
