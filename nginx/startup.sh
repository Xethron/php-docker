#!/usr/bin/env bash

cp /var/www/*/*.nginx.conf /etc/nginx/conf.d/;

nginx -g "daemon off;"
