FROM debian:bookworm-slim

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y vsftpd && rm -rf /var/lib/apt/lists/*

COPY ./conf/vsftpd.conf /etc/
COPY ./tools/run_ftp.sh /
RUN chmod +x /run_ftp.sh

WORKDIR /

EXPOSE 21

CMD [ "/run_ftp.sh" ]