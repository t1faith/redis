#!/bin/bash

cat > ./config/dashboard.toml << EOF
coordinator_name = "zookeeper"
coordinator_addr = "${ZK_HOST1}:2181,${ZK_HOST2}:2181,${ZK_HOST3}:2181"
product_name = "${CODIS_CLUSTER_NAME}"
product_auth = ""
admin_addr = "${CODIS_ADMIN_NAME}:18080"
migration_method = "semi-async"
migration_parallel_slots = 100
migration_async_maxbulks = 200
migration_async_maxbytes = "32mb"
migration_async_numkeys = 500
migration_timeout = "30s"
sentinel_client_timeout = "10s"
sentinel_quorum = 2
sentinel_parallel_syncs = 1
sentinel_down_after = "30s"
sentinel_failover_timeout = "5m"
sentinel_notification_script = ""
sentinel_client_reconfig_script = ""
EOF

cat > ./config/proxy.toml << EOF
product_name = "${CODIS_CLUSTER_NAME}"
product_auth = ""
session_auth = ""
admin_addr = "${CODIS_ADMIN_NAME}:11080"
proto_type = "tcp4"
proxy_addr = "${CODIS_PROXY_NAME}:19000"
EOF

./bin/codis-dashboard --ncpu=1 --config=config/dashboard.toml --log=dashboard.log --log-level=WARN &
./bin/codis-proxy --ncpu=1 --config=config/proxy.toml --log=proxy.log --log-level=WARN &
./bin/codis-fe --ncpu=1 --log=fe.log --log-level=WARN --zookeeper=${ZK_HOST1}:2181,${ZK_HOST2}:2181,${ZK_HOST3}:2181 --listen=${CODIS_ADMIN_NAME}:8080 &
sleep 3
#create proxy
./bin/codis-admin --dashboard=${CODIS_ADMIN_NAME}:18080 --create-proxy -x ${CODIS_ADMIN_NAME}:11080
#create group
for G_ID in `seq ${NODE_NUM}`
do
	./bin/codis-admin --dashboard=${CODIS_ADMIN_NAME}:18080 --create-group --gid=${G_ID}
	sleep 1
done

#pwd
#ls
sleep 5
#ls
tail -f ./proxy.log.$(date "+%Y-%m-%d")
