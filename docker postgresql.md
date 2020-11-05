# postgres on docker hub
https://hub.docker.com/_/postgres

# pull docker image
docker pull postgres

# list images
docker images

# run postgres on docker
docker run --name pegasus --rm -e POSTGRES_PASSWORD=banana -d -p 5432:5432 postgres

# list process
# docker ps -a

# exec command in container
docker exec -it pegasus psql -U postgres

# connect to postgres from terminal
psql -U postgres -h localhost

# stop process
docker stop pegasus

# persist data (using volume)
docker run --name pegasus --rm -e POSTGRES_PASSWORD=banana -d -p 5432:5432 -v pgdatavolume:/var/lib/postgresql/data postgres
