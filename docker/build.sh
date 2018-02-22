#!/bin/bash

SCRIPT_DIR=$(readlink -f $(dirname "$0"))
ROOT_DIR=$(dirname ${SCRIPT_DIR})
PROJECT_NAME=$(<${ROOT_DIR}/etc/project-name)

docker build ${SCRIPT_DIR}/builder \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    --tag ${PROJECT_NAME}-builder || exit 1

docker volume create ${PROJECT_NAME}-gradle || exit 1
docker volume create ${PROJECT_NAME}-embedpostgresql || exit 1

docker run \
    --rm \
    --user $(id -u):$(id -g) \
    --volume ${ROOT_DIR}:/app/sources \
    --volume ${PROJECT_NAME}-embedpostgresql:/app/.embedpostgresql \
    --volume ${PROJECT_NAME}-gradle:/app/.gradle \
    ${PROJECT_NAME}-builder || exit 1

cp ${ROOT_DIR}/boot/build/libs/boot.jar ${SCRIPT_DIR}/runner/boot.jar || exit 1

docker build ${SCRIPT_DIR}/runner \
    --tag ${PROJECT_NAME} || exit 1

rm ${SCRIPT_DIR}/runner/boot.jar || exit 1
