#!/bin/bash

touch /usr/local/zookeeper-3.4.11/conf/zoo.cfg
touch /data/zookeeper/myid

cat > /usr/local/zookeeper-3.4.11/conf/zoo.cfg << EOF
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/data/zookeeper
dataLogDir=/data/zklog
clientPort=2181
autopurge.snapRetainCount=3
autopurge.purgeInterval=1
server.1=${HOSTNAME1}:2222:3333
server.2=${HOSTNAME2}:2222:3333
server.3=${HOSTNAME3}:2222:3333
EOF

cat > /data/zookeeper/myid <<EOF
${SERVER_ID}
EOF

zkServer.sh start

tail -f /usr/local/zookeeper.out
