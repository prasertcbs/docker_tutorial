# basic commands
docker
docker --version
docker pull
docker images
docker image ls
docker ps
docker ps -a
docker container ls
docker container ls -a
docker run
docker exec -it alpine bash
docker container run
docker container stop
docker container start
docker container rm
docker image rm

# alpine
docker run alpine
docker run alpine cal # run single command then exit
docker run -it --rm alpine
docker run -it --rm alpine sh

## alpine container
cat /etc/os-release
apk add vim

# mysql
docker run --rm --name dolphin -p 3306:3306 -e MYSQL_ROOT_PASSWORD=banana -d mysql
docker exec -it dolphin bash

# what is tag
busybox
docker pull busybox
docker pull busybox:musl
docker run -it --rm busybox:musl