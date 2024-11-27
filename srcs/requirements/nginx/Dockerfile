FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

COPY ./conf/default /etc/nginx/sites-available/

COPY ./tools/nginx_start.sh /

WORKDIR /

RUN chmod +x nginx_start.sh

EXPOSE 443

CMD ["./nginx_start.sh"]
