FROM openjdk:8u151-jdk

ARG UID
ARG GID

RUN groupadd -g $GID app && useradd -u $UID -m -d /app -g app app
USER app

RUN mkdir /app/.gradle
RUN mkdir /app/.embedpostgresql

VOLUME /app/sources
VOLUME /app/.gradle
VOLUME /app/.embedpostgresql

WORKDIR /app/sources

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
