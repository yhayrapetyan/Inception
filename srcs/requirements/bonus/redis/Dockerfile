FROM debian:bookworm-slim

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y redis && rm -rf /var/lib/apt/lists/*

COPY ./tools/run_redis.sh /
RUN chmod +x /run_redis.sh

WORKDIR /etc/redis/

EXPOSE 6379

CMD [ "/run_redis.sh" ]