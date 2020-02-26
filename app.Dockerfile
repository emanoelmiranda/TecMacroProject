FROM ubuntu:18.04

WORKDIR /
EXPOSE 8080
USER root

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt update \
    && apt install unzip -y \
    && apt install default-jdk -y \
    && apt install wget -y \
    && apt update && apt-get install -y --no-install-recommends apt-utils

RUN wget http://ftp.unicamp.br/pub/apache/tomcat/tomcat-9/v9.0.31/bin/apache-tomcat-9.0.31.tar.gz \
    && tar -xvzf apache-tomcat-9.0.31.tar.gz \
    && mv apache-tomcat-9.0.31 /opt

RUN chmod +x /opt/apache-tomcat-9.0.31/bin/*.sh

COPY . /opt/apache-tomcat-9.0.31/webapps/
ADD ./server.xml /opt/apache-tomcat-9.0.31/conf/

CMD ["/opt/apache-tomcat-9.0.31/bin/catalina.sh", "run"]