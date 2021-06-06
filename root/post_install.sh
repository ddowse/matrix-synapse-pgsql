#!/bin/sh
mkdir /root/acme.sh
acme.sh --register-account -m ${EMAIL} --server letsencrypt
acme.sh --issue --standalone -d ${DOMAIN} --listen-v6 --listen-v4
