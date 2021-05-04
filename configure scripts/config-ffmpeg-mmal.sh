#git clone https://github.com/FFmpeg/FFmpeg.git
#cd FFmpeg
#sudo apt-get install libomxil-bellagio-dev
#git pull

export CONFIGURE_OPTIONS="
  --prefix=/usr --enable-gpl --enable-libx264 --enable-omx --enable-omx-rpi --enable-mmal 
  --disable-ffplay --disable-ffprobe --disable-doc 
  --disable-libxcb --disable-libxcb-shm --disable-libxcb-xfixes --disable-libxcb-shape
"

echo "
Configure options:
$CONFIGURE_OPTIONS

"

./configure $CONFIGURE_OPTIONS

#--enable-nonfree
#make -j 4
