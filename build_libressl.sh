#!/usr/bin/env zsh

set -e

if [ ! -d libressl ];then
  git clone -b v3.3.0 --depth=1 https://github.com/libressl-portable/portable.git libressl
  cd libressl && ./autogen.sh
else
  cd libressl
fi

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DLIBRESSL_SKIP_INSTALL=YES -DLIBRESSL_APPS=NO -DLIBRESSL_TESTS=NO \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -G Ninja  ..

ninja

# for building quiche with boringssl: QUICHE_BSSL_PATH=../boringssl
ln -s crypto/libcrypto.a libcrypto.a
ln -s ssl/libssl.a libssl.a

cd ..

if [ -d lib ];then
  rm -rf lib
fi

mkdir lib && cd lib

ln -s ../build/crypto/libcrypto.a libcrypto.a
ln -s ../build/ssl/libssl.a libssl.a

cd ..