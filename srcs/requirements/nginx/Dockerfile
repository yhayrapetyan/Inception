FROM alpine:3.1
RUN	apk update && apk upgrade && apk add  nginx openssl wget
COPY ./conf/default /etc/nginx/sites-available/
COPY ./tools/nginx_start.sh /
WORKDIR /
RUN chmod +x nginx_start.sh
EXPOSE 443
CMD ["./nginx_start.sh"]
