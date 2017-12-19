#!/bin/bash

for SERVER in `seq ${NODE_NUM}`
do
    #add redis-server to codis
    ./bin/codis-admin --dashboard=${CODIS_ADMIN_NAME}:18080 --group-add --gid=${SERVER} --addr=redis${SERVER}:7000
    ./bin/codis-admin --dashboard=${CODIS_ADMIN_NAME}:18080 --group-add --gid=${SERVER} --addr=redis${SERVER}:7001
    sleep 3
    #sync master & slave
    ./bin/codis-admin --dashboard=${CODIS_ADMIN_NAME}:18080 --sync-action --create --addr=redis${SERVER}:7000
    ./bin/codis-admin --dashboard=${CODIS_ADMIN_NAME}:18080 --sync-action --create --addr=redis${SERVER}:7001
	sleep 3
done

#每个group的SLOT
SLOT_AVE=$(expr 1024 / ${NODE_NUM})
#SLOT的起始值
SLOT_BEG=0
#SLOT的结束值
SLOT_END=$(expr 1024 / ${NODE_NUM})
#allot SLOTS
for G_ID in `seq ${NODE_NUM}`
do
    ./bin/codis-admin --dashboard=${CODIS_ADMIN_NAME}:18080 --slot-action --create-range --beg=${SLOT_BEG} --end=${SLOT_END} --gid=${G_ID}
    let SLOT_BEG=$SLOT_END+1
    let SLOT_END+=$SLOT_AVE
done

#tail -f /data/redis1/redis_7000.log /data/redis2/redis_7001.log
