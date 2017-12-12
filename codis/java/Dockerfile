FROM registry.cn-hangzhou.aliyuncs.com/1faith/ubuntu:16.04-myself

MAINTAINER 1faith twz1faith@gmail.com

ENV JAVA_VERSION 9.0.1
ENV JAVA_HOME /usr/local/jdk-${JAVA_VERSION}
ENV CLASS_PATH $JAVA_HOME/lib:$JAVA_HOME/jre/lib
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$JAVA_HOME/bin

#RUN wget http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}+11/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz?AuthParam=1512097525_eda1250fac517a7cfa11d0d858144a72

COPY jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz /usr/local

WORKDIR /usr/local

RUN tar xzf jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz \
	&& rm -rf jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz
#	&& { \
#			echo 'JAVA_HOME=/usr/local/jdk-${JAVA_VERSION}'; \
#			echo 'CLASS_PATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib'; \
#			echo 'export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:$JAVA_HOME/bin'; \
#		} >> /etc/profile
