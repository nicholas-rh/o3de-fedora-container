# Used to run the container on my machine, YMMV/may need to make some changes to get it working on another machine
docker run -dit -e "DISPLAY=$DISPLAY" -v /tmp/.X11-unix:/tmp/.X11-unix --network=host --device=/dev/dri --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --ulimit nofile=65536:65536 $1
