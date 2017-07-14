#!/bin/bash

set -e

_conf_new_folder="/tmp/docker-dnsmasq"
_dnsmasq_conf_new="$_conf_new_folder/dnsmasq.conf"
_dnsmasq_conf="$PROJECT_HOME/dnsmasq.conf"
_dnsmasq_lease="$PROJECT_HOME/dnsmasq.leases"

# copy custom config
[ -f $_dnsmasq_conf_new ] && cp $_dnsmasq_conf_new $_dnsmasq_conf

# checks
[ ! -f $_dnsmasq_conf ] && echo "$_dnsmasq_conf not found. Exiting ..." && \
exit 1

[ ! -f $_dnsmasq_lease ] && touch $_dnsmasq_lease

# start supervisord
"$@"
