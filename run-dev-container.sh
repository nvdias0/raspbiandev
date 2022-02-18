#!/bin/bash
# run script V220218-1058


[ "$(which docker)" == "" ] && echo "Docker not installed !" && exit

dockerimg=nvdias/raspbiandev
name=raspbian-dev
devdir=~/development


echo "
RASPERRY PI NATIVE DEVELOPMENT in docker

Tries to run the image in a previous existing container
and calls the bash command line.
at exit, the container stops and it will be kept for future runs.

If the image does not EXIST a pre-prepared imagem will be downloaded from
docker $dockerimg


Usage: $0 [options] [""{commands}""]

Options:
  --clean  clean container and run from default image
  --pull   clean container and download a pre-built image from $dockerimg
  --build  clean container and create image with all software (VERY SLOW)
  --help   display this help message     

{commands} execute a set of commads and exit
  examples:
   ""ls /""
   ""cd FFmpeg; git pull""     change directory and run git pull

Calling the script swithout parameters will run the container
with bash in iterative mode

------------------------------------------------------------------------------
"



# remove_container()
#
# cleans a previous existing container and runs from default image

function remove_container(){
	if [ "$(docker ps -a | grep $name)" != "" ]; then
	  echo "--> DELETING PREVIOUS CONTAINER"
	  docker container rm $name > /dev/null
	fi
}


# remove_image()
#
# removes exiting image (contsiner must be previously removed)

function remove_image(){
	if [ "$(docker images -a | grep $dockerimg)" != "" ]; then
	  echo "--> DELETING IMAGE"
	  docker rmi $dockerimg > /dev/null
	fi
}


# pull_docker()
#
# downloads a pre-set image from $dockerimg
# (fast)

function pull_docker() {
	docker pull $dockerimg
}


# build_image()
#
# download ubuntu image and all required software 
# (slow)

function build_image() {
   # Creates an image locally if it does not exist
   # add anything in "" to ignore build --> tries to load from docker.io on docker run
	if [ "$(docker images | grep $dockerimg)" == "" ]; then
		echo "--> DOCKER image creation."
		read -p "Press Return to continue " line
		docker build -t $dockerimg .
	fi
}


CMD=""
while [ "$1" != "" ]; do
		case "$1" in
			"--clean")              
				echo "Cleaning container."
				read -p "Press Return to continue " line
				remove_container
				;;
			"--pull")              
				echo "Cleaning container."
				echo "Remove image."
				echo "Downloading latest pre-built image from $dockerimg"
				read -p "Press Return to continue " line
				remove_container
				remove_image
				pull_docker
				;;
			"--build")              
				echo "Cleaning container."
				echo "Remove image."
				echo "Downloading ubuntu and installing software. (VERY SLOW)"
				read -p "Press Return to continue " line
				remove_container
				remove_image
				build_image
				;;
			"--help")
				# Already displayed the message, now exit
				exit
				;;
			*)
				# not any of the others, consider a command line.
				# ignore current argument and process the next
				CMD="$CMD $1;"
				;;
		esac
		shift
	done 

#if we got here with a command to exexcute do it without iteractive mode
#else "bash" will be called for iterative command prompt
if [ "$CMD" == "" ];then
  ITERACTIVE="-it"
  CMD="bash"
else
  ITERACTIVE=""
fi

mkdir -p $devdir


if [ "$(docker images | grep $dockerimg)" == "" ]; then
	echo "Image does not exist locally."
else
	echo "Using existing image"
fi

#########################################################################################################

if [ "$(docker ps -a | grep $name)" == "" ]; then
  # Container does not exist. Create container and start.
  # If image is not in local storage, downloads from docker.io
  echo "--> CREATE container"
  docker create \
  -v /storage:/storage \
  -v $devdir:/development \
  -w /development --privileged $ITERACTIVE \
  --hostname=$name \
  --name=$name \
  $dockerimg 
fi

if [ "$(docker ps | grep $name)" == "" ]; then
    # Container exists but is not running. Start Container

    echo "--> START container"
    docker start $name
    
    echo "--> EXECUTE \"$CMD\" in container"
    #read -p "Press Return to continue " line
    docker exec $ITERACTIVE $name bash -c "$CMD"
fi

if [ "$(docker ps | grep $name)" != "" ]; then
  # Container is running. Stop Container
  echo "--> DOCKER STOP ..."
  docker stop $name
fi
