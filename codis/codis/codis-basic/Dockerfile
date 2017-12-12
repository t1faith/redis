FROM registry.cn-hangzhou.aliyuncs.com/1faith/ubuntu:16.04-myself

MAINTAINER 1faith

ENV GO_VERSION 1.9.2
ENV GOROOT /usr/local/go 
ENV GOPATH /usr/local/codis
ENV CODIS_HOME $GOPATH/src/github.com/CodisLabs/codis
ENV PATH $PATH:$GOROOT/bin:$CODIS_HOME:/bin

ADD go1.9.2.linux-amd64.tar.gz /usr/local/

RUN mkdir -p $GOPATH/src/github.com/CodisLabs \
	#&& tar xzf /usr/local/go1.9.2.linux-amd64.tar.gz -C /usr/local/\
	#&& rm -rf /usr/local/go1.9.2.linux-amd64.tar.g \
	&& apt-get update \
	&& apt-get install make gcc git autoconf -y

##github上codis 3.2branch
ADD codis3.2.tar.gz $GOPATH/src/github.com/CodisLabs/

WORKDIR $CODIS_HOME

RUN pwd \
	&& ls \
	&& make

#codis basic image install complete
