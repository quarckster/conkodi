FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG KODI_VERSION=18.9

ENV DISPLAY=:99 

RUN apt update && \
    apt install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:team-xbmc/ppa && \
    apt -y purge openssl software-properties-common && \
    apt -y --purge autoremove && \
    apt install -y --no-install-recommends dumb-init \
                                           pulseaudio \
                                           ca-certificates \
                                           tigervnc-standalone-server \
                                           tigervnc-xorg-extension \
                                           kodi=2:${KODI_VERSION}+* && \
    apt -y --purge autoremove

COPY start.sh /
COPY guisettings.xml /home/kodi/.kodi/userdata/guisettings.xml

RUN chmod +x /start.sh && \
    touch /home/kodi/.Xauthority && \
    chgrp -R 0 /home/kodi/ && \
    chmod -R g=u /home/kodi/

WORKDIR /home/kodi

# VNC port
EXPOSE 5999
# HTTP port
EXPOSE 8080
# EventServer port
EXPOSE 9777

USER 1001
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start.sh"]
