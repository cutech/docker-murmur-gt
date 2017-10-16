FROM debian:stretch
MAINTAINER Òscar Casajuana <elboletaire@underave.net>

RUN useradd -u 1000 mumble \
 && apt-get update \
 && apt-get install -y mumble-server \
 && mkdir -p /murmur/data /murmur/config

ADD mumble-server.ini /murmur/config/mumble-server.ini

RUN chown -R 1000:1000 /murmur

VOLUME ["/murmur"]

EXPOSE 64738/udp

USER mumble

ENTRYPOINT ["/usr/sbin/murmurd", "-fg", "-ini", "/murmur/config/mumble-server.ini"]
