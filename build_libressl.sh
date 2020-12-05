#!/usr/bin/env zsh

set -e

if [ ! -d libressl ];then
  git clone -b v3.3.0 --depth=1 https://github.com/libressl-portable/portable.git libressl
fi

cd libressl
./autogen.sh

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DLIBRESSL_APPS=NO -DLIBRESSL_TESTS=NO \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -DCMAKE_INSTALL_PREFIX="${PWD}/../opt" \
      -G Ninja  ..

ninja

if [ -d "../opt" ];then
  rm -rf "../opt"
fi

ninja install