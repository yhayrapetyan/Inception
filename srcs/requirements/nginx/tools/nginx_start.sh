#!/bin/sh

cd /etc/nginx/sites-available/

if [ -f ./default ]; then
    sed -i "s#\$USERNAME#$USERNAME#g" default
    sed -i "s#\$SSL_CRT#$SSL_CRT#g" default
    sed -i "s#\$SSL_KEY#$SSL_KEY#g" default
fi

mkdir -p /tmp/nginx/client-body
chmod 777 /tmp/nginx/client-body

nginx -g "daemon off;"
