# docker-dnsmasq
A docker dnsmasq container with rpi branch

[![Build Status](https://img.shields.io/travis/alinmear/docker-dnsmasq.svg?style=flat?branch=rpi)](https://travis-ci.org/alinmear/docker-dnsmasq)
[![Github Stars](https://img.shields.io/github/stars/alinmear/docker-dnsmasq.svg?style=flat)](https://github.com/alinmear/docker-dnsmasq)
[![Github Forks](https://img.shields.io/github/forks/alinmear/docker-dnsmasq.svg?style=flat?label=github%20forks)](https://github.com/alinmear/docker-dnsmasq/)
[![Gitter](https://img.shields.io/gitter/room/alinmear/docker-dnsmasq.svg?style=flat)](https://gitter.im/alinmear/docker-dnsmasq)

# Usage

Provide your dnsmasq settings within a config folder mapped to `/tmp/docker-dnsmasq`. There are sample configs. Take a look at them.

# docker-compose.yml

```bash
version: '3'
services:
  dnsmasq:
    build: ./
    volumes:
      - ./config:/tmp/docker-dnsmasq
    cap_add:
      - NET_ADMIN
    environment:
      - "DNSMASQ_NAMESERVERS=8.8.8.8 8.8.4.4"
```
# Environment Variables

## `DNSMASQ_NAMESERVER`

Specify the forward nameservers. Values should be separated by a whitespace.
