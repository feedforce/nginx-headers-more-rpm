#!/bin/sh

set -xe

CENTOS_MAJOR_VERSION=$1
DOCKER_IMAGE=centos${CENTOS_MAJOR_VERSION}/nginx-rpm

docker run -u builder --name builder $DOCKER_IMAGE ./build-nginx.sh
docker cp builder:/home/builder/dist $CIRCLE_WORKING_DIRECTORY/dist
docker rm builder
