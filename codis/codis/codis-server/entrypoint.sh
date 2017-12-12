#!/bin/bash

mkdir -p /data/redis1
mkdir -p /data/redis2
mkdir -p /data/sentinel

cp ./config/redis.conf ./config/7000.conf
cp ./config/redis.conf ./config/7001.conf

cat > ./config/7000.conf <<EOF
#bind 127.0.0.1
protected-mode no
port 7000
tcp-backlog 511
timeout 0
tcp-keepalive 300
daemonize yes
supervised no
pidfile "/data/redis1/redis_7000.pid"
loglevel notice
logfile "/data/redis1/redis_7000.log"
databases 16
stop-writes-on-bgsave-error yes
rdbcompression no
rdbchecksum yes
dbfilename "dump.rdb"
dir "/data/redis1"
slave-serve-stale-data yes
slave-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-disable-tcp-nodelay no
appendonly no
appendfilename "appendonly.aof"
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
EOF

cat > ./config/7001.conf <<EOF
#bind 127.0.0.1
protected-mode no
port 7001
tcp-backlog 511
timeout 0
tcp-keepalive 300
daemonize yes
supervised no
pidfile "/data/redis2/redis_7001.pid"
loglevel notice
logfile "/data/redis2/redis_7001.log"
databases 16
stop-writes-on-bgsave-error yes
rdbcompression no
rdbchecksum yes
dbfilename "dump.rdb"
dir "/data/redis2"
slave-serve-stale-data yes
slave-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-disable-tcp-nodelay no
appendonly no
appendfilename "appendonly.aof"
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
EOF

if $DATA_PERSISTENT = yes;then
	echo "save 900 1" >> ./config/7000.conf
	echo "save 300 10" >> ./config/7000.conf
	echo "save 60 10000" >> ./config/7000.conf
	echo "save 900 1" >> ./config/7001.conf
	echo "save 300 10" >> ./config/7001.conf
	echo "save 60 10000" >> ./config/7001.conf
else
	echo 'save ""' >> ./config/7000.conf
	echo 'save ""' >> ./config/7001.conf
fi

#cat > ./config/sentinel.conf <<EOF
#protected-mode no
#port 26379
#daemonize yes
#dir "/data/sentinel"
#logfile "/data/sentinel/sentinel.log"
#EOF

./bin/codis-server ./config/7000.conf
./bin/codis-server ./config/7001.conf
#./bin/redis-sentinel ./config/sentinel.conf

tail -f /data/redis1/redis_7000.log /data/redis2/redis_7001.log
