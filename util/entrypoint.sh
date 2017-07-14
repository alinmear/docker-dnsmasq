#!/bin/bash

set -e


declare -A DEFAULTS
DEFAULTS["DNSMASQ_NAMESERVERS"]="${DNSMASQ_NAMESERVERS:="8.8.8.8 8.8.4.4"}"

_conf_new_folder="/tmp/docker-dnsmasq"
_dnsmasq_conf="/etc/dnsmasq.conf"
_dnsmasq_conf_d="/etc/dnsmasq.d"
_dnsmasq_resolv_conf="/etc/resolv.dnsmasq"
_resolv_conf="/etc/resolv.conf"
_default_conf="$_dnsmasq_conf_d/0_default.conf"

setup_export_defaults() {
	for var in ${!DEFAULTS[@]}; do
		export "$var=${DEFAULTS[$var]}"
	done
}

setup_resolv_conf() {
  echo "nameserver 127.0.0.1" > $_resolv_conf

  echo -n > $_dnsmasq_resolv_conf

  for _ns in $DNSMASQ_NAMESERVERS; do
    echo "nameserver $_ns" >> $_dnsmasq_resolv_conf
  done
}

setup_configs() {
	echo "resolv-file=/$_dnsmasq_resolv_conf" > $_default_conf
  # configomat.sh "DNSMASQ_" $_dnsmasq_conf
}

# copy custom config
if [ -d $_conf_new_folder ]
then
	[[ $(ls "$_conf_new_folder/" | grep ".*.conf" | wc -l) > 0 ]] && cp $_conf_new_folder/*.conf $_dnsmasq_conf_d
fi

setup_export_defaults
setup_configs
setup_resolv_conf

# start supervisord
"$@"
