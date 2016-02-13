#!/bin/bash

set -e

export CON_NAME=oraclejdk_t
export REG_URL=index.csphere.cn
export IMAGE=microimages/oraclejdk
export TAGS="8 8u73"
export BASE_IMAGE=microimages/alpine-glibc

docker pull $BASE_IMAGE

docker build -t $IMAGE .
echo "> start testing ..."
./test.sh

docker tag -f $IMAGE $REG_URL/$IMAGE
for t in $TAGS; do
  docker tag -f $IMAGE $REG_URL/$IMAGE:$t
  docker tag -f $IMAGE $IMAGE:$t
done

docker push $IMAGE
docker push $REG_URL/$IMAGE
