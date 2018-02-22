FROM openjdk:8u151-jre

RUN groupadd app && useradd -m -d /app -g app app
USER app

WORKDIR /app

COPY boot.jar /app/boot.jar
RUN mkdir /app/.embedpostgresql

EXPOSE 8080

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

