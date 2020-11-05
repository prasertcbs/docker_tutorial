# instruction arguments
FROM postgres:11
RUN mkdir /root/data
WORKDIR /root/data
COPY src .
# COPY src /root/data
RUN apt-get update -y && \
    apt-get install -y vim curl && \
    rm -rf /var/lib/apt/lists/*
