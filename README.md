Repository includes some _Dockerfile_ templates for robotics applications. It works for any graphics cards.

## Dockerfiles templates

1. `dockerfiles/Dockerfile.simple` - minimalistic template includes 

    - basics dependenties


2. `dockerfiles/Dockerfile.vnc` - minimalistic template includes 

    - basics dependenties
    - web vnc based on [noVNC](https://github.com/novnc/noVNC)

_Pretty good exapmle from [github.com/robotology](https://github.com/robotology/icub-gazebo-grasping-sandbox/tree/master/dockerfiles)_

## Example or how to use

```
git clone https://github.com/kirillin/my-docker-configs.git
cd my-docker-configs
```

Do new copy of Dockerfile.`template`

```
copy Dockerfile.template Dockerfile
```

and modify it whatever you want.


### To build new image

For your own `Dockerfile_name` and `image_name`

```
bash docker_build.bash Dockerfile_name image_name
```

### To run container

#### Use web-based VNC gui

```
bash docker_run.bash -v -i image_name
```

#### Use computer's gui

```
bash docker_run.bash -i image_name
```

_if you have _nvidia_ graphics card, then use key _-n_ or _--nvidia__



### To exec container (open bash session within existing container)

```
bash docker_exec.bash container_name
```

