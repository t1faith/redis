FROM registry.cn-hangzhou.aliyuncs.com/1faith/java:9.0.1

MAINTAINER 1FAITH

ENV ZK_VERSION 3.4.11
ENV ZK_HOME /usr/local/zookeeper-3.4.11
ENV PATH $PATH:$ZK_HOME/bin

RUN mkdir -p /data/zookeeper \
	&& mkdir -p /data/zklog \
	&& echo 'zookeeper logs' >> /data/zklog/zookeeper.log

COPY zookeeper-3.4.11.tar.gz /usr/local/
#COPY zoo.cfg /usr/local/zookeeper-3.4.11/conf/
#COPY myid /data/zookeeper/
COPY entrypoint.sh /usr/local/bin

#RUN wget http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz

RUN tar xzf zookeeper-3.4.11.tar.gz \
	&& rm -rf zookeeper-3.4.11.tar.gz

VOLUME /data

EXPOSE 2181
EXPOSE 2222
EXPOSE 3333

ENTRYPOINT ["entrypoint.sh"]

#CMD ["zkServer.sh", "start"]
