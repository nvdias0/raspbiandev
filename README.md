# raspbiandev

Native raspberry pi compilation in LibreELEC with docker

Tested in LibreELEC and osmc.
Docker must be installed.

Includes:
- raspbian jester
- vc bins and libs
- basic dev tools for raspberry pi compilation
- starts in /development that will map from the host ~/development

## download and extract
    wget https://github.com/nvdias0/raspbiandev/archive/refs/heads/main.zip
    unzip main.zip
    rm main.zip
    
## run
    cd raspbiandev-main
    ./run.sh


### Notes
A docker image will be commited to the docker hub for a direct download.

It will be faster to download, but it will not include the run script
