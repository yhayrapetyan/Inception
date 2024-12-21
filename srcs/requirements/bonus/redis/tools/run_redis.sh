#!/bin/bash

if [ ! -f "/etc/redis/redis.conf.bak" ]; then
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" ./redis.conf
    sed -i "s|# maxmemory <bytes>|maxmemory 5mb|g" ./redis.conf
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" ./redis.conf

    cp ./redis.conf ./redis.conf.bak
fi

redis-server --protected-mode no --requirepass $REDIS_PASSWORD;