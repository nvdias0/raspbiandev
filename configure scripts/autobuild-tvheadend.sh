# configuration for tvheadend with NOT TRANSCODING
# dynamic libs = aprox. 9MB (4MB after compression)
# needs some libs:
# sudo apt install libavfilter-dev libswresample-dev libavresample-dev libswscale-dev libavformat-dev libavcodec-dev libavutil-dev libx264-dev libopus-dev libva-dev 


export MAKEFLAGS="-j 4"
export LDFLAGS="-L/opt/vc/lib $LDFLAGS"
export AUTOBUILD_CONFIGURE_EXTRA="--enable-libsystemd_daemon --enable-hdhomerun_static --jobs=4 --disable-mantainder-mode --disable-dependency-tracking --disable-ffmpeg_static --disable-libav --disable-bundle --disable-libx264_static --disable-libx265_static --disable-libfdkaac_static --disable-libmfx_static --disable-libx264 --disable-libx265 --disable-libfdkaac --disable-libmfx --disable-libopus_static --disable-libtheora_static --disable-libvorbis_static --disable-libvpx_static --disable-libopus --disable-libtheora --disable-libvorbis --disable-libvpx --disable-nvenc --disable-android --disable-kqueue --disable-mmal --disable-omx"

echo "
tvheadend COMPILATION OPTIONS to be used:
"
echo $AUTOBUILD_CONFIGURE_EXTRA
echo "

Press ENTER to START ...  "
read
./Autobuild.sh
