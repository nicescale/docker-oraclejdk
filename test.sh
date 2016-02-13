#!/bin/bash

set -xe

docker rm -f "$CON_NAME" > /dev/null 2>&1 || true
docker run -d --name $CON_NAME $IMAGE sleep 1000

PROGRAM=Hello

cat <<EOF > /tmp/$PROGRAM.java
public class Hello{
  public static void main(String args[]){
    System.out.println("Hello cSphere!");
  }
}
EOF

docker cp /tmp/$PROGRAM.java $CON_NAME:/app/
docker exec $CON_NAME javac $PROGRAM.java
docker exec $CON_NAME java $PROGRAM|grep "Hello cSphere"

docker rm -f $CON_NAME

echo "---> The test pass"
