# raspbiandev
native raspberry pi compilation in LibreELEC with docker

Tested in LibreELEC and osmc.
Docker must be installed.

Just download, extract and run script. It will create the docker image if needed and run a container.


## download and extract
    wget https://github.com/nvdias0/raspbiandev/archive/refs/heads/main.zip
    unzip main.zip
    rm main.zip
    
## run
    cd raspbiandev
    ./run.sh


### Notes
A docker image will be commited to the docker hub for a direct download.

It will be faster to download, but it will not include the run script



