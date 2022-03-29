#run with:
#docker build -t nvdias/raspbiandev .

FROM ubuntu:20.04
WORKDIR /root

# update bashrc
RUN printf " \n\
export LS_OPTIONS='--color=auto' \n\
alias ls='ls \$LS_OPTIONS' \n\
alias ll='ls \$LS_OPTIONS -l' \n\
alias l='ls \$LS_OPTIONS -lA' \n\
alias make='make -j4' \n\
export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/opt/vc/lib:/usr/lib:/usr/local/lib \n\
" >> .bashrc

# update packages
RUN apt-get -y update
RUN apt-get install -y apt-utils

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Lisbon
RUN apt-get install -y tzdata

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
 libxcb-xfixes0-dev libxcb1-dev libxml2-dev lzma-dev zlib1g-dev libdrm-dev \
 patchelf ncurses-dev kmod bc \
 python3-dev python3-pip   
 
# transmission dependencies
RUN apt-get -y install build-essential automake autoconf libtool \
pkg-config intltool libcurl4-openssl-dev libglib2.0-dev \
libevent-dev libminiupnpc-dev libgtk-3-dev libappindicator3-dev

# tvheadend dependencies
RUN apt-get -y install libdvbcsa-dev libhdhomerun-dev gettext python pngquant \
libpcre2-dev ccache libavahi-client-dev \
debhelper liburiparser-dev python3-requests

# download, compile and install libiconv needed by tvheadend
RUN wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.16.tar.gz \
 && tar -xf libiconv-1.16.tar.gz \
 && cd libiconv-1.16 \
 && ./configure --prefix=/usr/local \
 && make \
 && make install \
 && cd .. \
 && rm -r libiconv-1.16

# tvheadend nightlies accessable with "apt-get download tvheadend"
# it will download the last dpkg package which can be unpacked with "dpkg -x tvheadendxxxx.dpkg ."
RUN apt-get -y install coreutils apt-transport-https lsb-release ca-certificates \
 && wget -qO- https://doozer.io/keys/tvheadend/tvheadend/pgp | apt-key add - \
 && echo "deb http://apt.tvheadend.org/unstable raspbian-stretch main" > /etc/apt/sources.list.d/tvheadend.list


# install upx for compressing binaries (after strip)
RUN apt-get -y install upx

# install vc from raspberry pi and needed libcrypto for LE11 compatibility
RUN wget https://github.com/nvdias0/raspbiandev/archive/refs/heads/main.zip \
 && unzip main.zip \
 && mkdir -p /opt \
 && cp -r raspbiandev-main/vc /opt/ \
 && rm -r raspbiandev-main \
 && rm main.zip \
 && chmod a+x /opt/vc/bin/* 
 
