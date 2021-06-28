FROM ubuntu:latest
ARG base_url="http://www.dolphindb.com/downloads/"

ARG dolphindb_version="DolphinDB_Linux64_V1.30.10.zip"

ARG dolphindb="${base_url}${dolphindb_version}"
ENV DEBIAN_FRONTEND noninteractive
EXPOSE 8848
RUN mkdir -p /dolphin
RUN apt-get update
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN apt-get install tzdata
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
RUN (cd /dolphin && wget ${dolphindb})
RUN (cd /dolphin && unzip /dolphin/${dolphindb_version})
RUN chmod 755 /dolphin/server/dolphindb

ADD default_cmd /root
RUN chmod 755 /root/default_cmd
ENTRYPOINT [ "/root/default_cmd" ]

