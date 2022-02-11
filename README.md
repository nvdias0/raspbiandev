# raspbiandev

Native raspberry pi compilation with DOCKER

Tested in LibreELEC and Osmc.

Docker must be installed.


Includes:
- ubuntu 20.04 for raspberry pi
- vc bins and libs
- basic dev tools for raspberry pi compilation
- starts in /development that will map from the host ~/development

## Download and extract
    wget https://github.com/nvdias0/raspbiandev/archive/refs/heads/main.zip
    unzip main.zip
    rm main.zip
    
## Run
    cd raspbiandev-main
    ./run.sh


### Notes
- run.sh script tries to reuse a previous container keeping last chagens.
- run.sh --clean  resets the container as to the initial image.
- run.sh --pull   forces to pull updated image.
- run-sh --build  forces creating imagem from ubuntu and install all software (VERY SLOW)
- docker image is available in the docker hub nvdias/raspbiandev for a direct download and install. It will be faster to download then making everything.
- You should need 800 MB storage to have the image in your system.


### Suggested git projects for Raspberry pi compilation
These projects can be easly compiled with this docker image.
Assuming you know how to compile (git pull; .configure; make -j4).
There are some suggested configuration scripts available.

- FFmpeg
https://github.com/FFmpeg/FFmpeg.git

- nginx
https://github.com/nginx/nginx.git

- nginx rtmp module
https://github.com/arut/nginx-rtmp-module.git

- tvheadend
https://github.com/tvheadend/tvheadend.git
