FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget php-cli php php-mysql && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html
RUN wget https://www.adminer.org/latest.php -O adminer.php
RUN mv adminer.php /var/www/html/index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]