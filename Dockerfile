FROM       alpine:latest
MAINTAINER Paul Steinlechner <paul.steinlechner@pylonlabs.at>

RUN set -xe \
&& apk add --update --no-progress dnsmasq supervisor bash \
&& rm -rf /var/cache/apk/*

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
