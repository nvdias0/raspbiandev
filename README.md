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
- The run script always deletes a previous run container: this means that any changes made to the development image will not be kept between runs. Of couse that all compilation done in the /development directory is mantained.
- To keep changes between runs, just edit the run.sh script and comment the "docker container rm" line.
- A docker image is also available in the docker hub for a direct download and install. It will be faster to download, but it will not include the run script as in this git.
