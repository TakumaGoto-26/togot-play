#!/bin/sh

sudo /etc/init.d/nginx start && sudo /etc/init.d/php-fpm start
tail -f /dev/null