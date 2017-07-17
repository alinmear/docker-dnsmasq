FROM       resin/armv7hf-debian-qemu:latest
MAINTAINER Paul Steinlechner <paul.steinlechner@pylonlabs.at>

ENV DEBIAN_FRONTEND=noninteractive

RUN [ "cross-build-start" ]

RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install dnsmasq supervisor && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add files
ADD util/entrypoint.sh /entrypoint.sh
ADD util/supervisord.conf /etc/supervisord.conf
ADD util/supervisord_dnsmasq.conf /etc/supervisor/conf.d/dnsmasq.conf

# Expose needed ports
EXPOSE 67/udp 67/tcp 53/tcp 53/udp

RUN chmod +x /entrypoint.sh

COPY util/docker-configomat/configomat.sh /usr/local/bin
RUN chmod +x /usr/local/bin/*

RUN [ "cross-build-end" ]

ENTRYPOINT ["/entrypoint.sh"]
cmd ["/usr/bin/supervisord"]
