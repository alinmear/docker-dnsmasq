FROM       alpine:latest
MAINTAINER Paul Steinlechner <paul.steinlechner@pylonlabs.at>

ENV PROJECT_HOME=/opt/docker-dnsmasq

RUN set -xe \
&& apk add --update --no-progress dnsmasq supervisor bash \
&& rm -rf /var/cache/apk/* && \
mkdir -p $PROJECT_HOME

# Add files
ADD util/entrypoint.sh /entrypoint.sh
ADD util/supervisord.conf /etc/supervisord.conf
ADD util/supervisord_dnsmasq.conf /etc/supervisor/conf.d/dhcpd.conf

# Expose needed ports
EXPOSE 67/udp 67/tcp 53/tcp 53/udp

RUN chmod +x /entrypoint.sh

COPY util/docker-configomat/configomat.sh /usr/local/bin
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/entrypoint.sh"]
cmd ["/usr/bin/supervisord"]
