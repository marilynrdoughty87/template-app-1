FROM ubuntu:14.04

# curl for downloading java
# python, gcc and build-essential for compiling node-gyp modules
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python2.7 \
    gcc \
    build-essential

WORKDIR /opt

RUN curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz | tar -zxv
RUN ln -s jdk* /opt/jdk

RUN locale-gen en_US.UTF-8

ARG UID
ARG GID

RUN groupadd -g $GID app && useradd -u $UID -m -d /app -g app app
USER app

ENV JAVA_HOME /opt/jdk
COPY entrypoint.sh /

RUN mkdir /app/.gradle
RUN mkdir /app/.embedpostgresql

VOLUME /app/sources
VOLUME /app/.gradle
VOLUME /app/.embedpostgresql

WORKDIR /app/sources

ENTRYPOINT ["/entrypoint.sh"]
