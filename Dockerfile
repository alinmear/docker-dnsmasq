FROM       resin/rpi-raspbian
MAINTAINER Paul Steinlechner <paul.steinlechner@pylonlabs.at>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -q -y -o "DPkg::Options::=--force-confold" apt-utils && \
    apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade && \
    apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install dnsmasq man supervisor && \
    apt-get -q -y autoremove && \
    apt-get -q -y clean && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add files
ADD util/entrypoint.sh /entrypoint.sh
ADD util/supervisord.conf /etc/supervisord.conf
ADD util/supervisord_dnsmasq.conf /etc/supervisor/conf.d/dnsmasq.conf

# Expose needed ports
EXPOSE 67/udp 67/tcp 53/tcp 53/udp

RUN chmod +x /entrypoint.sh

COPY util/docker-configomat/configomat.sh /usr/local/bin
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/entrypoint.sh"]
cmd ["/usr/bin/supervisord"]
