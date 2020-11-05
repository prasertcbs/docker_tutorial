# amazonlinux (fedora)

docker run -it --name aladdin amazonlinux

yum update -y
yum install vim -y

exit # exit bash

# create a new image from container
docker ps -a
docker commit aladdin amazonlinux:tutorial

# run a container with vim
docker run -it --name linuxbox amazonlinux:tutorial
