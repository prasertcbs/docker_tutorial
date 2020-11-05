# postgresql
* https://hub.docker.com/_/postgres

## how to run container
* docker run --rm --name pegasus -e POSTGRES_PASSWORD=banana -d -p 5432:5432 postgres

## persist data 
* docker run --rm --name pegasus -e POSTGRES_PASSWORD=banana -d -p 5432:5432 -v pgvolume:/var/lib/postgresql/data postgres

# pgadmin4
docker pull dpage/pgadmin4
docker run --name pg4 -p 80:80 -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' -e 'PGADMIN_DEFAULT_PASSWORD=banana' -d dpage/pgadmin4

localhost:80

get postgres server ip
docker network ls
docker network inspect bridge

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

## pgadmin4 storage folder
/var/lib/pgadmin/storage/postgres/

## copy files between host and pgamin4 containter
cd playground
docker cp disney*.* pg4://var/lib/pgadmin/storage/postgres/
docker container cp pg4://var/lib/pgadmin/storage/postgres/disney_db.tar ~/.