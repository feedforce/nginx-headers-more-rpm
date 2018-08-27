#!/bin/sh

set -xe

CENTOS_MAJOR_VERSION=$1
DOCKER_IMAGE=centos${CENTOS_MAJOR_VERSION}/nginx-rpm

# ref: https://circleci.com/docs/2.0/building-docker-images/#mounting-folders
docker create -v $CIRCLE_WORKING_DIRECTORY/dist:/shared:rw --name tmp busybox /bin/true
docker run -u builder --volumes-from tmp $DOCKER_IMAGE ./build-nginx.sh
docker cp tmp:/dist $CIRCLE_WORKING_DIRECTORY/dist
