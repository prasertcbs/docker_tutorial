- [docker tutorial](#docker-tutorial)
- [install docker on Ubuntu 20.04](#install-docker-on-ubuntu-2004)
- [microsoft sql server](#microsoft-sql-server)
  - [run a container](#run-a-container)
  - [exec](#exec)
  - [persist data](#persist-data)
    - [docker volume (prefer)](#docker-volume-prefer)
    - [create mount volume](#create-mount-volume)
  - [sample scripts for (mssql)](#sample-scripts-for-mssql)
- [mysql](#mysql)
  - [install mysql-client, mysql-shell, mysql-workbench-community](#install-mysql-client-mysql-shell-mysql-workbench-community)
  - [work with mysql & mysqlsh (recommend)](#work-with-mysql--mysqlsh-recommend)
  - [exec](#exec-1)
  - [attach shell in VS Code Docker extension](#attach-shell-in-vs-code-docker-extension)
  - [work with mysqlsh](#work-with-mysqlsh)
  - [fix MySQL authen on VSCode](#fix-mysql-authen-on-vscode)
  - [create new user](#create-new-user)
  - [create test database](#create-test-database)
    - [persist data](#persist-data-1)
      - [use volume (prefer method)](#use-volume-prefer-method)
      - [create own directory and mount volume](#create-own-directory-and-mount-volume)
- [postgresql](#postgresql)
  - [install psql-client on Ubuntu](#install-psql-client-on-ubuntu)
  - [how to run container](#how-to-run-container)
  - [exec](#exec-2)
  - [attach shell in VS Code Docker extension](#attach-shell-in-vs-code-docker-extension-1)
  - [interactive run](#interactive-run)
  - [how to persist data](#how-to-persist-data)
    - [volume (prefer)](#volume-prefer)
    - [create dir and mount (avoid)](#create-dir-and-mount-avoid)
  - [create demo database](#create-demo-database)
  - [dump to sql script (create table and insert statement)](#dump-to-sql-script-create-table-and-insert-statement)
  - [run sql script from command line](#run-sql-script-from-command-line)
- [pgadmin4](#pgadmin4)
- [docker stack](#docker-stack)
  - [deploy stack.yml](#deploy-stackyml)
  - [stop](#stop)
- [nodejs](#nodejs)
- [etc](#etc)
  - [delete running container](#delete-running-container)
  - [remove image](#remove-image)
  - [create a new image from a container](#create-a-new-image-from-a-container)

# docker tutorial
* https://docker-curriculum.com/
* 
# install docker on Ubuntu 20.04
* https://linuxconfig.org/how-to-install-docker-on-ubuntu-20-04-lts-focal-fossa
  1. sudo apt install docker.io
  2. sudo systemctl enable --now docker
  3. sudo usermod -aG docker SOMEUSERNAME
  4. docker --version
  5. docker run hello-world
   
# microsoft sql server
* https://hub.docker.com/_/microsoft-mssql-server
* docker pull mcr.microsoft.com/mssql/server

## run a container
docker run --name maroon -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=5HEe1Ybq' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server

## exec
docker exec -it maroon /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 5HEe1Ybq


## persist data
### docker volume (prefer)
docker run --name maroon -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=5HEe1Ybq' -p 1433:1433 -v sqlvolume:/var/opt/mssql -d mcr.microsoft.com/mssql/server

### create mount volume
docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=5HEe1Ybq' -p 1433:1433 -v <host directory>/data:/var/opt/mssql/data -v <host directory>/log:/var/opt/mssql/log -v <host directory>/secrets:/var/opt/mssql/secrets -d mcr.microsoft.com/mssql/server

1. mkdir ${HOME}/Develop
1. mkdir ${HOME}/Develop/mssql_data
 
docker run --name maroon -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=5HEe1Ybq' -p 1433:1433 -v /home/zelda/Develop/mssql/data:/var/opt/mssql/data -v /home/zelda/Develop/mssql/log:/var/opt/mssql/log -v /home/zelda/Develop/mssql/secrets:/var/opt/mssql/secrets -d mcr.microsoft.com/mssql/server


## sample scripts for (mssql)
create database foody;
go
use foody;
go
create table food(id int, descr nvarchar(10));

insert into food values (1, 'egg'), (2, 'rice');

select * from food;

insert into food values (3, 'meat ball'), (4, 'hotdog');

select * from food;

# mysql
* https://hub.docker.com/_/mysql
* https://medium.com/@crmcmullen/how-to-run-mysql-8-0-with-native-password-authentication-502de5bac661

## install mysql-client, mysql-shell, mysql-workbench-community

## work with mysql & mysqlsh (recommend)
1. docker run --name dolphin --rm -p 3306:3306 -e MYSQL_ROOT_PASSWORD=banana -d mysql
2. docker run --name dolphin --rm -p 3306:3306 -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=dolphin -d mysql
3. mysql -u root -p -P 3306 --protocol=tcp
4. mysql -u root -p -h localhost -P 3306 --protocol=tcp 
5. mysqlsh root@localhost:3306 --sql

## exec
docker exec -it dolphin mysql -u root -p

## attach shell in VS Code Docker extension

## work with mysqlsh
1. docker run --name dolphin -p 3306:3306 -p 33060:33060/tcp -e MYSQL_ROOT_HOST=% -e MYSQL_ROOT_PASSWORD=dolphin -d mysql
1. mysqlsh root@localhost:3306 --sql
2. mysql -u root -p --protocol=tcp
4. mysql -u root -p -h localhost -P 3306 --protocol=tcp

## fix MySQL authen on VSCode
1. docker exec -it dolphin mysql -u root -p
2. ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'banana';
3. ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'banana';

## create new user
CREATE USER genie IDENTIFIED WITH mysql_native_password BY 'dolphin';
GRANT ALL PRIVILEGES ON *.* TO genie;
grant grant option on *.* to genie;

## create test database
create database demo;
use demo;
create table menu(id int, descr text, price int);
insert into menu values
    (1, 'mocha', 40),
    (2, 'latte', 50),
    (3, 'ชา', 30),
    (4, 'ชาเขียว', 60);
select * from menu;

### persist data
#### use volume (prefer method)
docker run --name dolphin --rm -v mysqlvolume:/var/lib/mysql -p 3306:3306 -p 33060:33060/tcp -d -e MYSQL_ROOT_PASSWORD=dolphin -e MYSQL_ROOT_HOST=% mysql

#### create own directory and mount volume
* source: https://medium.com/@crmcmullen/how-to-run-mysql-in-a-docker-container-on-macos-with-persistent-local-data-58b89aec496a
1. mkdir ${HOME}/Develop
1. mkdir ${HOME}/Develop/mysql_data
1. mkdir ${HOME}/Develop/mysql_data/8.0
1. docker network create dev-network 
2. docker run --rm --name dolphin -v /home/zelda/Develop/mysql_data/8.0:/var/lib/mysql -p 3306:3306 -p 33060:33060/tcp -d -e MYSQL_ROOT_PASSWORD=dolphin -e MYSQL_ROOT_HOST=% mysql
3. mysqlsh root@localhost --sql


# postgresql
* https://hub.docker.com/_/postgres
## install psql-client on Ubuntu
sudo apt install postgresql-client-12

## how to run container
* docker run --rm --name pegasus -e POSTGRES_PASSWORD=banana -d postgres
* docker run --rm --name pegasus -e POSTGRES_PASSWORD=banana -d -p 5432:5432 postgres

## exec
* docker exec -it pegasus psql -U postgres

## attach shell in VS Code Docker extension

## interactive run
??

## how to persist data 
### volume (prefer)
* docker run --rm --name pegasus -e POSTGRES_PASSWORD=banana -d -p 5432:5432 -v pgvolume:/var/lib/postgresql/data postgres

### create dir and mount (avoid)
1. mkdir -p $HOME/docker/volumes/postgres
1. docker run --rm --name pegasus -e POSTGRES_PASSWORD=banana -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
1. psql -U postgres -h localhost

## create demo database
create database demo;
\c demo
create table menu(id int, descr text, price int);
insert into menu values
    (1, 'mocha', 40),
    (2, 'latte', 50),
    (3, 'ชา', 30),
    (4, 'ชาเขียว', 60);
select * from menu;

## dump to sql script (create table and insert statement)
pg_dump --file "dump.sql" --host "192.168.211.136" --port "5432" --username "postgres" --verbose --format=p --no-owner --create --no-privileges --no-tablespaces --no-unlogged-table-data --inserts --table "public.province2" "covid19"

## run sql script from command line
createdb demo -U postgres -h localhost
psql -U postgres -h localhost -d demo -f province3.sql

# pgadmin4
docker pull dpage/pgadmin4
docker run -p 80:80 --name pg4 -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' -e 'PGADMIN_DEFAULT_PASSWORD=dolphin' -d dpage/pgadmin4
open web browser
localhost:80
เอา postgres server ip จาก ip a (e.g., 192.168.211.134 not localhost)

/var/lib/pgadmin
/var/lib/pgadmin/storage/postgres/

cd playground
docker cp disney.sql pg4://var/lib/pgadmin/storage/postgres/
docker container cp pg4://var/lib/pgadmin/storage/postgres/disney_db.tar ~/.

# docker stack
## deploy stack.yml
docker stack deploy -c stack.yml postgres

## stop
docker node ls
docker swarm leave --force

# nodejs
docker run --name nx -it node:current-slim


# etc
docker images

docker ps -a

## delete running container
docker rm --force pegasus

## remove image
docker rmi pegasus

docker exec -it pegasus bash

## create a new image from a container
