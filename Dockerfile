FROM 1faith/ubuntu:16.04-base

RUN set -ex; \
	wget -O redis.tar.gz http://download.redis.io/releases/redis-4.0.2.tar.gz; \
	mkdir -p /usr/src/redis; \
	tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1; \
	rm redis.tar.gz; \
#关闭保护模式
	grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h; \
	sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h; \
	grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h; \
#编译安装
	apt-get install make gcc ruby -y; \
	make -C /usr/src/redis; \
	make -C /usr/src/redis install; \
	gem install redis

RUN	mkdir /data; \
	mkdir -p /data/7001; \
	mkdir -p /data/7002; \
	mkdir -p /data/7003; \
	mkdir -p /data/7004; \
	mkdir -p /data/7005; \
	mkdir -p /data/7006

COPY 7001.conf /data/7001/redis.conf
COPY 7002.conf /data/7002/redis.conf
COPY 7003.conf /data/7003/redis.conf
COPY 7004.conf /data/7004/redis.conf
COPY 7005.conf /data/7005/redis.conf
COPY 7006.conf /data/7006/redis.conf

VOLUME /data

WORKDIR /data

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 7001
EXPOSE 7002
EXPOSE 7003
EXPOSE 7004
EXPOSE 7005
EXPOSE 7006
#CMD ["redis-server" , "/data/redis.conf"]
