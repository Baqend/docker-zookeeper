# docker-zookeeper
The reason why we created this docker image is that we wanted to have a simple way to spin up multi-node ZooKeeper deployments. In particular, we wanted the docker container to create the ZooKeeper `myID` file autonomously, so that we could spawn ZooKeeper containers in single-line statements.  
We are currently not aware of another easy approach to do that. 

## Simple multi-node ensembles

Suppose you wanted a 3-node ZooKeeper ensemble on machines with the hostnames `zk1`, `zk2` and `zk3`, run the following on every ensemble node:

	docker run -d --restart=always \
	      -p 2181:2181 \
	      -p 2888:2888 \
	      -p 3888:3888 \
	      -v /var/lib/zookeeper:/var/lib/zookeeper \
	      -v /var/log/zookeeper:/var/log/zookeeper  \
	      baqend/zookeeper zk1,zk2,zk3 $ID
Obviously, the `-p` commands expose the ports required by ZooKeeper per default. The two `-v` commands provide persistence in case of container failure by mapping the directories the ZooKeeper container uses to the corresponding host directories. The comma-separated list of hostnames tells ZooKeeper what servers are in the ensemble. This is the same for every node in the ensemble. The only variable is the ZooKeeper ID (`$ID`), because it is unique for every container. This means you have to provide every container with its ID (`1`, `2` and `3`, respectively). And that's it.  
All ZooKeeper-related data are stored on the host. On start, the ZooKeeper `myID` file is created anew.

For an example of how we use this image, also see our [tutorial on how to use Storm with Docker Swarm](https://github.com/Baqend/tutorial-swarm-storm).

**Note:** ZooKeeper only accepts IDs between 1 and 255!

## Build Process

All build parameters are provided in file `params.sh`. The following command builds and pushes the image with all versions provided in the final: 

	. allVersions.sh build push 
(This is basically just a reminder for us and not interesting for most of you ;-) )