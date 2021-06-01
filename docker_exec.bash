#!/usr/bin/env bash

CONTAINER_NAME=$1

docker exec -it ${CONTAINER_NAME} /bin/bash