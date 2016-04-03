FROM ubuntu:14.04
MAINTAINER wingerath wolfram@wingerath.org

ENV ZOOKEEPER_VERSION zookeeper-3.4.8

WORKDIR /usr/share/zookeeper

# Install dependencies and set everything up as described here:
# https://zookeeper.apache.org/doc/r3.1.2/zookeeperAdmin.html#ch_deployment

EXPOSE 2181 2888 3888

# Install stuff
RUN \
   apt-get update -y && apt-get install -y \
   wget

# Download and install ZooKeeper
RUN wget -q -N http://mirror.dkd.de/apache/zookeeper/$ZOOKEEPER_VERSION/$ZOOKEEPER_VERSION.tar.gz
RUN tar xzf $ZOOKEEPER_VERSION.tar.gz
RUN rm $ZOOKEEPER_VERSION.tar.gz

RUN mv $ZOOKEEPER_VERSION/* /usr/share/zookeeper

# Install Java 8
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y  software-properties-common && \
  add-apt-repository ppa:webupd8team/java -y && \
  apt-get update && \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get install -y oracle-java8-installer && \
  apt-get clean

# default parameters for config file:
ENV tickTime=2000
ENV dataDir=/var/lib/zookeeper/
ENV dataLogDir=/var/log/zookeeper/
ENV clientPort=2181
ENV initLimit=5
ENV syncLimit=2

# add startup script
ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/usr/share/zookeeper/entrypoint.sh"]