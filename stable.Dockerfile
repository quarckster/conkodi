FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG KODI_VERSION=18.9

ENV DISPLAY=:99 

RUN apt update && \
    apt install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:team-xbmc/ppa && \
    apt -y purge openssl software-properties-common && \
    apt -y --purge autoremove

RUN apt install -y --no-install-recommends dumb-init \
                                           fluxbox \
                                           tigervnc-standalone-server \
                                           tigervnc-xorg-extension \
                                           kodi=2:${KODI_VERSION}+* && \
    apt -y --purge autoremove

COPY start.sh /

RUN chmod +x /start.sh && \
    useradd -m -s /bin/bash kodi && \
    touch /home/kodi/.Xauthority && \
    chown -R kodi /home/kodi    

USER kodi
WORKDIR /home/kodi

EXPOSE 5999
EXPOSE 8080
EXPOSE 9090
EXPOSE 5555

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start.sh"]
