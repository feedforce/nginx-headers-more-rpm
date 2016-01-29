#!/bin/sh

set -xe

CENTOS_MAJOR_VERSION=$1
DOCKER_IMAGE=centos${CENTOS_MAJOR_VERSION}/nginx-rpm
docker run -u builder -v $CIRCLE_ARTIFACTS:/shared:rw $DOCKER_IMAGE ./build-nginx.sh
