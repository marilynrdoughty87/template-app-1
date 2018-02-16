FROM ubuntu:14.04

# curl for downloading java
RUN apt-get update && apt-get install -y \
    curl

WORKDIR /opt

RUN curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/server-jre-8u151-linux-x64.tar.gz
RUN ln -s jdk1.8.* /opt/jdk
ENV PATH /opt/jdk/bin:$PATH

RUN locale-gen en_US.UTF-8

RUN groupadd app && useradd -m -d /app -g app app
USER app

WORKDIR /app

COPY boot.jar /app/boot.jar
RUN mkdir -p /app/.embedpostgresql

EXPOSE 8080

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

