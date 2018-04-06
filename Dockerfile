############################################################
# Dockerfile install dnsmasq
# Based on resin/rpi-raspbian
############################################################

FROM resin/raspberry-pi-alpine:latest

MAINTAINER JTSchuilenga

RUN apk --no-cache add dnsmasq \
    && echo "conf-dir=/etc/dnsmasq,*.conf" > /etc/dnsmasq.conf
EXPOSE 53/tcp 53/udp 67/udp

VOLUME ["/etc/dnsmasq"]

CMD dnsmasq -k --dhcp-broadcast

