FROM baqend/java:8u171
MAINTAINER wingerath wolfram@wingerath.org

# The used ZooKeeper version can also be supplied like this with the build command like this:
# --build-arg BIN_VERSION=zookeeper-3.4.8
ARG BIN_VERSION=zookeeper-3.4.10

WORKDIR /usr/share/zookeeper

EXPOSE 2181 2888 3888

# Install and set everything up
RUN \
   wget -q -N http://mirror.dkd.de/apache/zookeeper/$BIN_VERSION/$BIN_VERSION.tar.gz \
&& tar --strip-components=1 -C /usr/share/zookeeper -xvf ${BIN_VERSION}.tar.gz \
&& rm $BIN_VERSION.tar.gz \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# default parameters for config file:
ENV tickTime=2000
ENV dataDir=/var/lib/zookeeper/
ENV dataLogDir=/var/lib/zookeeper/
ENV clientPort=2181
ENV initLimit=5
ENV syncLimit=2
ENV purgeInterval=24

# add startup script
ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/usr/share/zookeeper/entrypoint.sh"]