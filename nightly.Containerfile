FROM docker.io/library/ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY=:99 \
    HOME=/home/kodi

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common gpg-agent && \
    add-apt-repository -y ppa:team-xbmc/xbmc-nightly && \
    apt install -y --no-install-recommends dumb-init \
                                           pulseaudio \
                                           ca-certificates \
                                           tigervnc-standalone-server \
                                           tigervnc-xorg-extension \
                                           kodi && \
    apt-get -y purge openssl software-properties-common gpg-agent && \
    apt-get -y --purge autoremove && \
    apt-get clean

COPY start.sh /
COPY guisettings.xml /home/kodi/.kodi/userdata/guisettings.xml

RUN chmod +x /start.sh && \
    touch /home/kodi/.Xauthority && \
    mkdir /tmp/.X11-unix && \
    chgrp -R 0 /home/kodi/ /tmp/.X11-unix/ && \
    chmod -R g=u /home/kodi/ /tmp/.X11-unix/

WORKDIR /home/kodi

# VNC port
EXPOSE 5999
# HTTP port
EXPOSE 8080
# EventServer port
EXPOSE 9777/udp

USER 1001
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start.sh"]
