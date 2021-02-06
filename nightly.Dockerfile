FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY=:99

RUN apt update && \
    apt install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:team-xbmc/xbmc-nightly && \
    apt -y purge openssl software-properties-common && \
    apt -y --purge autoremove

RUN apt install -y --no-install-recommends dumb-init \
                                           pulseaudio \
                                           ca-certificates \
                                           tigervnc-standalone-server \
                                           tigervnc-xorg-extension \
                                           kodi && \
    apt -y --purge autoremove && \
    useradd -m -s /bin/bash kodi

COPY start.sh /
COPY guisettings.xml /home/kodi/.kodi/userdata/guisettings.xml

RUN chmod +x /start.sh && \
    touch /home/kodi/.Xauthority && \
    chown -R kodi /home/kodi

USER kodi
WORKDIR /home/kodi

# VNC port
EXPOSE 5999
# HTTP port
EXPOSE 8080

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start.sh"]
