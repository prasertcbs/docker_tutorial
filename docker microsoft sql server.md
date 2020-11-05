# microsoft sql server
* https://hub.docker.com/_/microsoft-mssql-server
* docker pull mcr.microsoft.com/mssql/server

# config
https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-docker?view=sql-server-ver15

docker --version

docker image ls

## run a container
docker run --rm --name maroon -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=5HEe1Ybq' -e 'MSSQL_PID=Express' -p 1433:1433 -d mcr.microsoft.com/mssql/server

## exec
docker exec -it maroon /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 5HEe1Ybq

## persist data
### docker volume (prefer)
docker run --rm --name maroon -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=5HEe1Ybq' -p 1433:1433 -v sqlvolume:/var/opt/mssql -d mcr.microsoft.com/mssql/server

### sample script
create database foody;
go
use foody;
go
create table food(id int, descr nvarchar(10));

insert into food values (1, 'egg'), (2, N'ข้าว');

select * from food;

insert into food values (3, 'meat ball'), (4, 'hotdog');

select * from food;