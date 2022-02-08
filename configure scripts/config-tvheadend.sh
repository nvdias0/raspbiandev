# configuration for tvheadend without TRANSCODING and libs DYNAMIC

# WORKS ONLY ON LE9

# dynamic libs = aprox. 9MB (4MB after compression)
# needs some libs:
# sudo apt install libavfilter-dev libswresample-dev libavresample-dev libswscale-dev libavformat-dev libavcodec-dev libavutil-dev libx264-dev libopus-dev libva-dev 


export MAKEFLAGS="-j 4"
export LDFLAGS="-L/opt/vc/lib $LDFLAGS"

# FROM AUTOBULD
export AUTOBUILD_CONFIGURE_EXTRA="
--enable-libsystemd_daemon --enable-hdhomerun_static --jobs=4 --disable-mantainder-mode
 --disable-dependency-tracking --disable-ffmpeg_static --disable-libav --disable-bundle 
 --disable-libx264_static --disable-libx265_static --disable-libfdkaac_static --disable-libmfx_static 
 --disable-libx264 --disable-libx265 --disable-libfdkaac --disable-libmfx --disable-libopus_static
 --disable-libtheora_static --disable-libvorbis_static --disable-libvpx_static --disable-libopus
 --disable-libtheora --disable-libvorbis --disable-libvpx --disable-nvenc --disable-android 
 --disable-kqueue --disable-mmal --disable-omx
 "

#from LIBREELEC shared with bundle --> OK <---
export AUTOBUILD_CONFIGURE_EXTRA="
--prefix=/usr --disable-static --enable-shared --enable-bundle
--disable-ffmpeg_static --disable-libav --disable-libx264 --disable-libx265 --disable-mmal --disable-omx
--disable-libvpx --disable-libtheora --disable-libvorbis --disable-libopus --disable-libfdkaac
--disable-libx264_static --disable-libx265_static --disable-libfdkaac_static
--disable-libvpx_static --disable-libtheora_static --disable-libvorbis_static --disable-libopus_static
--disable-dbus_1 --enable-dvbcsa --disable-dvben50221 --disable-dvbscan 
--enable-hdhomerun_client --disable-hdhomerun_static --enable-epoll --enable-inotify 
--enable-pngquant --disable-libmfx_static --disable-nvenc --disable-uriparser --enable-tvhcsa 
--enable-trace --nowerror --disable-bintray_cache --python=/usr/bin/python --disable-hdhomerun
--enable-pcre2 --disable-vaapi --enable-ccache --enable-avahi 
--enable-libiconv
"

export LDFLAGS="$LDFLAGS -ldbus-1 -lpcre2-8 -lavahi-common -lavahi-client -lssl -lcrypto -lz"
export LDFLAGS="$LDFLAGS -ldl -lpthread -lm -lrt -lc -lgcc_s -lpcre"

echo "
Configure options:
$AUTOBUILD_CONFIGURE_EXTRA

"

#configure only. Follow by make -j 4  && strip build.linux/tvheadend
./configure $AUTOBUILD_CONFIGURE_EXTRA


#configure, make and build package.
#./Autobuild.sh

exit 0

