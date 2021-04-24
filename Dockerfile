#run with:
#docker build -t nvdias/raspbiandev .

FROM raspbian/stretch

WORKDIR /root

# update bashrc
RUN echo "export LS_OPTIONS='--color=auto'" >> .bashrc \
 && echo "alias ls='ls $LS_OPTIONS'" >> .bashrc \
 && echo "alias ll='ls $LS_OPTIONS -l'" >> .bashrc \
 && echo "alias l='ls $LS_OPTIONS -lA'" >> .bashrc \
 && echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/vc/lib" >> .bashrc
 
# update packages
RUN apt-get -y update
#apt-get upgrade

# install build tools and major libraries
RUN apt-get -y install \
 autoconf automake build-essential bison flex cmake git subversion dialog libtool \
 nasm pkg-config texinfo vim wget yasm zip \
 libomxil-bellagio-bin libomxil-bellagio-dev \
 libasound2-dev libass-dev libavcodec-dev libavdevice-dev libavfilter-dev libavformat-dev \
 libavutil-dev libfreetype6-dev libgmp-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev    \
 libopus-dev librtmp-dev libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev libsdl2-ttf-dev   \
 libsnappy-dev libsoxr-dev libv4l-dev libva-dev libvdpau-dev  libssl-dev \
 libvo-amrwbenc-dev libvorbis-dev libwebp-dev libx264-dev libx265-dev libxcb-shape0-dev libxcb-shm0-dev  \
 libxcb-xfixes0-dev libxcb1-dev libxml2-dev lzma-dev zlib1g-dev \
 python3-dev python3-pip   

# install vc from raspberry pi
RUN wget https://github.com/nvdias0/raspbiandev/archive/refs/heads/main.zip \
 && unzip main.zip \
 && mkdir -p /opt \
 && cp -r raspbiandev-main/vc /opt/ \
 && rm -r raspbiandev-main \
 && rm main.zip \
 && chmod a+x /opt/vc/bin/*
 
 