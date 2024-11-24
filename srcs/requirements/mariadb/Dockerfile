FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/init.sql /sql-initialization.d/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod +x /database-initialization.d/init.sql

RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf && \
    chown root:root /etc/mysql/mariadb.conf.d/50-server.cnf

#if I remove this line mariadb container will write mariadb exited with code 0 but it don't actualy exit
RUN mkdir -p /var/run/mysqld

WORKDIR /sql-initialization.d/

EXPOSE 3306

CMD ["mysqld"]
