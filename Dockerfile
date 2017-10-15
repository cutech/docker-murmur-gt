FROM debian:stretch
MAINTAINER cutech <cody@c-u-tech.com>

RUN useradd -u 1000 mumble \
 && apt-get update \
 && apt-get install -y mumble-server wget screen unzip \
 && mkdir -p /murmur/data /murmur/config
 RUN wget -P /murmur "https://www.gametracker.com/downloads/gtmurmur/1.2.0-bin.zip" \
 && unzip /murmur/1.2.0-bin.zip -d /murmur  

ADD mumble-server.ini /murmur/config/mumble-server.ini

RUN chown -R 1000:1000 /murmur

VOLUME ["/murmur"]

EXPOSE 64738
EXPOSE 64738/udp

EXPOSE 27800
EXPOSE 27800/udp

USER mumble

ENTRYPOINT ["/usr/sbin/murmurd", "-fg", "-ini", "/murmur/config/mumble-server.ini", "&&", "screen", "-d", "-m", "bash", "-c", "/murmur/1.2.0/gtmurmur-static", "/murmur/config/mumble-server.ini"]
