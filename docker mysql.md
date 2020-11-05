# mysql on docker hub
https://hub.docker.com/_/mysql

cat /etc/os-release

systemctl status docker
docker --version

# pull docker image
docker pull mysql

# list images
docker images

# run mysql on docker
docker run --name dolphin --rm -p 3306:3306 -e MYSQL_ROOT_PASSWORD=banana -d mysql

# run on 3307 port
docker run --name whale --rm -p 3307:3306 -e MYSQL_ROOT_PASSWORD=banana -d mysql

# list process
docker ps -a

# exec command in container
docker exec -it dolphin mysql -u root -p

docker exec -it dolphin bash

# attach shell (VS Code docker)
## check linux version
cat /etc/os-release
apt update
apt install neovim
apt install curl
cd
curl -o b.sql https://raw.githubusercontent.com/prasertcbs/basic-dataset/master/mysql_data/disney_mysql.sql

# connect to mysql from terminal
* mysql -u root -p -h localhost -P 3306 --protocol=tcp
* mysql -u root -p -P 3306 --protocol=tcp
* mysqlsh root@localhost:3306 --sql
* mysqlsh root@localhost:3306 -f foody.sql

# stop process
docker stop dolphin

# persist data (using volume)
docker run --name dolphin --rm -p 3306:3306 -d -e MYSQL_ROOT_PASSWORD=banana -v mysqlvolume:/var/lib/mysql mysql

# MySQL + phpmyadmin
docker run --rm --name dolphin -v mysql_datavolume:/var/lib/mysql -p 3306:3306 -p 33060:33060/tcp -d -e MYSQL_ROOT_PASSWORD=banana mysql
docker run --rm --name myadmin -d --link dolphin:db -p 8080:80 phpmyadmin/phpmyadmin