FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

COPY tools/run_mariadb.sh /sql-initialization.d/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf && \
    chown root:root /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /sql-initialization.d/run_mariadb.sh

RUN mkdir -p /var/run/mysqld

WORKDIR /sql-initialization.d/

EXPOSE 3306

CMD ["./run_mariadb.sh"]
