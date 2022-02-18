#!/bin/bash

echo "
nginx-patch

As libcrypt versions are different in nginx and le,
after compiling nginx we need to patch it and deliver
libcrypto.so.1 with it.
"

[ ! -f "nginx" ] && echo "nginx not found !" && exit

if [ "$(patchelf --print-needed nginx | grep '\$ORIGIN/libcrypt.so.1')" != "" ];then
	echo "nginx already patched !"
	exit
fi

cp -i /lib/arm-linux-gnueabihf/libcrypt.so.1 .
strip nginx
patchelf --add-needed "\$ORIGIN/libcrypt.so.1" nginx

echo "Patch applied"
echo "Deliver nginx with libcrypt.so.1"

