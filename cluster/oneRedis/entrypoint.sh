#!/bin/bash

redis-server /data/redis.conf

#rediscluster应该传入
#cd /usr/src/redis/src
#./redis-trib.rb create --replicas 1 rediscluster:7001 rediscluster:7002 rediscluster:7003 rediscluster:7004 rediscluster:7005 rediscluster:7006 << EOF
#yes
#EOF

#cd /usr/src/redis/utils/create-cluster
#create-cluster start
#create-cluster create

#watch -n 30 pwd
