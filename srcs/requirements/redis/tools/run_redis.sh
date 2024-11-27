#!/bin/bash

#sleep 30
#sysctl vm.overcommit_memory=1
#sysctl -p

if [ ! -f "/etc/redis/redis.conf.bak" ]; then

#    cat redis.conf
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" ./redis.conf
    sed -i "s|# maxmemory <bytes>|maxmemory 5mb|g" ./redis.conf
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" ./redis.conf

    cp ./redis.conf ./redis.conf.bak

#    echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf
#    sysctl restart
#    sysctl vm.overcommit_memory=1
fi

redis-server --protected-mode no --requirepass $REDIS_PASSWORD;