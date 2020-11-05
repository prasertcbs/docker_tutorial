docker build -t sql_lab .
docker tag sql_lab prasertcbs/sql_lab:1.0
docker login -u prasertcbs
docker push prasertcbs/sql_lab:1.0
docker image rm prasertcbs/sql_lab:1.0
docker pull prasertcbs/sql_lab:1.0
