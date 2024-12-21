#!/bin/bash

mkdir -p /var/www/html
mkdir -p /var/run/vsftpd/empty

adduser "$FTP_USER" --disabled-password &>/dev/null
echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd &> /dev/null
adduser "$FTP_USER" root


/usr/sbin/vsftpd /etc/vsftpd.conf