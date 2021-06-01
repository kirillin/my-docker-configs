#!/usr/bin/env bash

USE_NVIDIA=false
USE_VNC=false
IMAGE_NAME=""
CONTAINER_NAME=""

## Arguments parsing
args=("$@") 
N=${#args[@]}

if [[ $N = 0 ]]
then
    echo "How to use me:"
    echo "Use -n or --nvidia for nvidia and comuter's graphics"
    echo "Use -v for vnc and web graphics"
    echo "Use -i for image_name seting"
    echo "Use -c for container_name seting"
else
    for ((i=0; i<$N; i++)); do
        arg=${args[${i}]}
        if [[ $arg = "-n" ]] || [[ $arg = "--nvidia" ]]
        then
            # echo "-n ${args[ (( ${i} + 1 )) ]}"
            USE_NVIDIA=true
        elif [[ $arg = "-v" ]]
        then
            # echo "-v ${args[ (( ${i} + 1 )) ]}"
            USE_VNC=true
        elif [[ $arg = "-i" ]]
        then
            # echo "-i ${args[ (( ${i} + 1 )) ]}"
            IMAGE_NAME=${args[ (( ${i} + 1 )) ]}
        elif [[ $arg = "-c" ]]
        then
            # echo "-c ${args[ (( ${i} + 1 )) ]}"    
            CONTAINER_NAME=${args[ (( ${i} + 1 )) ]}
        fi
    done

    if [[ $CONTAINER_NAME = "" ]]
    then 
      CONTAINER_NAME=$IMAGE_NAME
    fi

    echo "Image name: $IMAGE_NAME"
    echo "Container name: $CONTAINER_NAME"

    xhost +local:docker || true

    ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

    if [[ $USE_NVIDIA = true ]]
    then
      docker run --gpus all \
                  -ti --rm \
                  -e "DISPLAY" \
                  -e "QT_X11_NO_MITSHM=1" \
                  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
                  -e XAUTHORITY \
                  -v /dev:/dev \
                  -v /home/$USER/:/root \
                  --net=host \
                  --privileged \
                  --name ${CONTAINER_NAME} ${IMAGE_NAME}
    elif [[ $USE_VNC = true ]]
    then
        docker run  -ti --rm \
                    -p 6080:6080 \
                    --user human \
                    -v /dev:/dev \
                    -v /home/$USER/:/root \
                  --net=host \
                  --name ${CONTAINER_NAME} ${IMAGE_NAME}
    else
        docker run  -ti --rm \
                    -p 6080:6080 \
                    --user human \
                    -e "DISPLAY" \
                    -e "QT_X11_NO_MITSHM=1" \
                    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
                    -e XAUTHORITY \
                    -v /dev:/dev \
                    -v /home/$USER/:/root \
                  --net=host \
                  --name ${CONTAINER_NAME} ${IMAGE_NAME}
    fi
fi
