#!/bin/bash

#
# run script V210430-1211
#
# This script creates a docker image for
# RASPERRY PI NATIVE DEVELOPMENT in closed systems (as LIBREELEC).
# 
# No need to use a PC to compile or fed up your raspbian with tons of dev binaries.
# 
# At each run, the script runs the image in a new container
# and call the bash command line.
# at exit, the container stops and is deleted (the image is kept for next runs).
#
# if you want to keep changes to the container (new binaries, libs or configs),
# just comment the container removal at the start of the script.
#
#
# Calling the script without parameters gives shell access
# Passing parameters to the script will execute them and exit.
# example:
#   ./run.sh "cd FFmpeg; git pull"
#

[ "$(which docker)" == "" ] && echo "Docker not installed !" && exit

dockerimg=nvdias/raspbiandev
name=raspbian-dev
devdir=~/development

ITERACTIVE="-it"

if [ "$1" == "" ];then
  ITERACTIVE="-it"
  CMD="bash"
else
  ITERACTIVE=""
  CMD="$*"
fi

mkdir -p $devdir


# Creates an image locally if it does not exist
# add anything in "" to ignore build --> tries to load from docker.io on docker run

if [ "$(docker images | grep $dockerimg)" == "" ]; then
 echo "--> DOCKER image creation."
 echo "this will take a lot of time!" 
 read -p "Press Return to start " $line
 docker build -t $dockerimg .
 echo > .local_build
fi


#########################################################################################################
# COMMENT the "docker container rm" line to KEEP CHANGES IN CONTAINER (bins, libs, etc) between calls
#########################################################################################################

if [ "$(docker ps -a | grep $name)" != "" ]; then
  echo "--> DELETE PREVIOUS CONTAINER"
  docker container rm $name > /dev/null
fi

#########################################################################################################



if [ "$(docker ps -a | grep $name)" == "" ]; then
  # Container does not exist. Create container and start. If image is not in local storage, download from docker.io
  echo "--> DOCKER RUN  ..."
  docker run -v $devdir:/development -w /development --privileged $ITERACTIVE --hostname=$name --name=$name $dockerimg bash -c "$CMD"

else
  if [ "$(docker ps | grep $name)" == "" ]; then
    # Container exists but is not running. Start Container

    echo "--> DOCKER START ..."
    docker start $name
    
    echo "--> DOCKER EXEC bash"
    docker exec $ITERACTIVE $name bash -c "$CMD"
  fi
fi

if [ "$(docker ps | grep $name)" != "" ]; then
  # Container is running. Stop Container
  echo "--> DOCKER STOP ..."
  docker stop $name
fi
