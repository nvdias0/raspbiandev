# raspbiandev

Native raspberry pi compilation with DOCKER

Tested in LibreELEC and Osmc.

Docker must be installed.


Includes:
- raspbian jester
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
A docker image will be commited to the docker hub for a direct download.
It will be faster to download, but it will not include the run script
