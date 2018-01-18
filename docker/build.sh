#!/bin/bash

SCRIPT_DIR=$(readlink -f $(dirname "$0"))
ROOT_DIR=$(dirname ${SCRIPT_DIR})
PROJECT_NAME=$(<${ROOT_DIR}/etc/project-name)

docker build ${SCRIPT_DIR}/builder \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    --tag ${PROJECT_NAME}-builder || exit 1

docker volume create skeleton-builder-gradle || exit 1
docker volume create skeleton-builder-embedpostgresql || exit 1

docker run \
    --net=host \
    --rm \
    --user $(id -u):$(id -g) \
    --volume ${ROOT_DIR}:/app/sources \
    --volume skeleton-builder-embedpostgresql:/app/.embedpostgresql \
    --volume skeleton-builder-gradle:/app/.gradle \
    ${PROJECT_NAME}-builder || exit 1

cp ${ROOT_DIR}/build/libs/${PROJECT_NAME}.jar ${SCRIPT_DIR}/runner/app.jar || exit 1

docker build ${SCRIPT_DIR}/runner \
    --tag ${PROJECT_NAME} || exit 1

rm ${SCRIPT_DIR}/runner/app.jar || exit 1
