#!/bin/bash

for i in {7001..7005}
do
	cd /data/$i
	redis-server /data/$i/redis.conf &
done

cd /data/7006
redis-server /data/7006/redis.conf

#rediscluster应该传入
#cd /usr/src/redis/src
#./redis-trib.rb create --replicas 1 rediscluster:7001 rediscluster:7002 rediscluster:7003 rediscluster:7004 rediscluster:7005 rediscluster:7006 << EOF
#yes
#EOF

#cd /usr/src/redis/utils/create-cluster
#create-cluster start
#create-cluster create

cd /data

#watch -n 30 pwd
