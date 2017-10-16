FROM debian:stretch
MAINTAINER cutech <cody@c-u-tech.com>

RUN useradd -u 1000 mumble \
 && apt-get update \
 && apt-get install -y mumble-server wget unzip screen \
 && mkdir -p /murmur/data /murmur/config
 
ADD mumble-server.ini /murmur/config/mumble-server.ini
ADD mumble-server.ini /murmur/murmur.ini
ADD gtmurmur-static /murmur

RUN chmod +x /murmur/gtmurmur-static && chown -R 1000:1000 /murmur

VOLUME ["/murmur"]

EXPOSE 64738
EXPOSE 64738/udp
EXPOSE 27800
EXPOSE 27800/udp

USER mumble

ENTRYPOINT ["/usr/sbin/murmurd", "-fg", "-ini", "/murmur/config/mumble-server.ini"]
