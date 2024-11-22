#!/bin/sh

#sign certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $SSL_KEY -out $SSL_CRT -subj "/C=AM/L=Yerevan/O=42/OU=student/CN=$DOMAIN_NAME"

cd /etc/nginx/sites-available/

if [ -f ./default ]; then
    sed -i "s#\$USERNAME#$USERNAME#g" default
    sed -i "s#\$SSL_CRT#$SSL_CRT#g" default
    sed -i "s#\$SSL_KEY#$SSL_KEY#g" default
fi

mkdir -p /tmp/nginx/client-body
chmod 777 /tmp/nginx/client-body

nginx -g "daemon off;"
