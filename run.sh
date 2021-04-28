#!/bin/bash

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

[ "$(which docker)" == "" ] && echo "Docker not installed !" && exit

dockerimg=nvdias/raspbiandev
name=raspbian-dev
devdir=~/development

mkdir -p $devdir


# Creates an image locally if it does not exist

if [ "$(docker images | grep $dockerimg)" == "" ]; then
 echo "--> DOCKER image creation."
 echo "this will take a lot of time!" 
 read -p "Press Return to start " $line
 docker build -t $dockerimg .
 echo > .local_build
fi

# download / update image - don't use if the image was created with  a local build
# [ ! -f .local_build ] && echo docker pull $dockerimg



#########################################################################################################
#
# COMMENT the followimg line to KEEP CHANGES IN CONTAINER (bins, libs, etc) between calls
#

docker container rm $name > /dev/null

#########################################################################################################



if [ "$(docker ps -a | grep $name)" == "" ]; then
  # Container does not exist. Create container and start.
  echo "--> DOCKER RUN  ..."
  docker run -v $devdir:/development -w /development --privileged -it --hostname=$name --name=$name $dockerimg bash 

else
  if [ "$(docker ps | grep $name)" == "" ]; then
    # Container exists but is not running. Start Container

    echo "--> DOCKER START ..."
    docker start $name
    
    echo "--> DOCKER EXEC bash"
    docker exec -it $name bash
  fi
fi

if [ "$(docker ps | grep $name)" != "" ]; then
  # Container is running. Stop Container
  echo "--> DOCKER STOP ..."
  docker stop $name
fi
