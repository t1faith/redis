#!/bin/bash

#$CLUSTER_IP应该传入
cd /usr/src/redis/src
./redis-trib.rb create --replicas 1 $CLUSTER_IP1:6379 $CLUSTER_IP2:6379 $CLUSTER_IP3:6379 $CLUSTER_IP4:6379 $CLUSTER_IP5:6379 $CLUSTER_IP6:6379 << EOF
yes
EOF

cd /data

#watch -n 30 pwd
