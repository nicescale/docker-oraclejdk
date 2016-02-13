#!/bin/bash

set -e

export CON_NAME=oraclejdk_t
export REG_URL=index.csphere.cn
export IMAGE=microimages/oraclejdk
export TAGS="7u79"
export BASE_IMAGE=microimages/alpine-glibc

docker pull $BASE_IMAGE

docker build -t $IMAGE:7 .
echo "> start testing ..."
./test.sh

docker tag -f $IMAGE:7 $REG_URL/$IMAGE:7
for t in $TAGS; do
  docker tag -f $IMAGE:7 $REG_URL/$IMAGE:$t
  docker tag -f $IMAGE:7 $IMAGE:$t
  docker push $IMAGE:$t
  docker push $REG_URL/$IMAGE:$t
done

docker push $IMAGE:7
docker push $REG_URL/$IMAGE:7

