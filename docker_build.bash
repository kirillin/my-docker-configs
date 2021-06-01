#!/usr/bin/env bash

DOCKERFILE=$1
IMAGE_NAME=$2
UBUNTU_VERSION=$3

if [[ $# < 3 ]] 
then
  UBUNTU_VERSION="18.04"
fi

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

echo "Ubuntu version: ${UBUNTU_VERSION}"
echo "Use dockerfile: ${ROOT_DIR}/dockerfiles/${DOCKERFILE}"
echo "Build image with name: ${IMAGE_NAME}"
read -n 1 -s -r -p "Press any key to continue"


if [[ $1 = "--nvidia" ]] || [[ $1 = "-n" ]]
  then
    docker build -t ${IMAGE_NAME} -f ${ROOT_DIR}/dockerfiles/${DOCKERFILE} ${ROOT_DIR} \
                                  --network=host \
                                  --build-arg from="nvidia/opengl:1.0-glvnd-runtime-ubuntu${UBUNTU_VERSION}"

else
    echo "[!] If you wanna use nvidia gpu, please rebuild with -n or --nvidia argument"
    docker build -t ${IMAGE_NAME} -f ${ROOT_DIR}/dockerfiles/${DOCKERFILE} ${ROOT_DIR} \
                                  --network=host \
                                  --build-arg from="ubuntu:${UBUNTU_VERSION}"
fi