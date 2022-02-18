#
# Compilation for nginx AND MAKE
# make is mandatory due to the environment vaibles changes
# for transcoding and streaming 
#

export CONFIGURE_OPTIONS="
  --with-http_ssl_module
  --with-http_dav_module
  --with-http_flv_module
  --with-http_mp4_module
  --with-http_gunzip_module
  --with-http_gzip_static_module
  --with-http_auth_request_module
  --add-module=../nginx-rtmp-module
"

 # --with-ld-opt=\"\"
 # --with-cc-opt=\"\"
 # --with-ld-opt="-L /development/libcrypt"

echo "
Configure options:
$CONFIGURE_OPTIONS

LD_LIBRARY_PATH:
$LD_LIBRARY_PATH
"
read -p "Press return to configure " line
./configure $CONFIGURE_OPTIONS

echo  "

nginx must be patched after make:

  cp /lib/arm-linux-gnueabihf/libcrypt.so.1 .
  strip nginx
  patchelf --add-needed "\$ORIGIN/libcrypt.so.1" nginx

deliver nginx + libcrypt.so.1
"
