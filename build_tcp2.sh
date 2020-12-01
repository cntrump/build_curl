#!/usr/bin/env zsh

set -e

if [ ! -d ngtcp2 ];then
  git clone --depth=1 https://github.com/ngtcp2/ngtcp2.git
fi

cd ngtcp2

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DBUILD_SHARED_LIBS=NO \
      -DENABLE_OPENSSL=YES \
      -DOPENSSL_ROOT_DIR=../boringssl \
      -DLIBNGHTTP3_INCLUDE_DIR=../../nghttp3/libnghttp3/include \
      -DLIBNGHTTP3_LIBRARY=../../nghttp3/libnghttp3/lib/libnghttp3.a \
      -G Ninja  ..

ninja && cd ..

if [ -d libngtcp2 ];then
  rm -rf libngtcp2
fi

mkdir libngtcp2 && mkdir -p libngtcp2/include/ngtcp2 && mkdir libngtcp2/lib

cp build/lib/libngtcp2.a libngtcp2/lib
cp build/lib/includes/ngtcp2/version.h libngtcp2/include/ngtcp2
cp lib/includes/ngtcp2/ngtcp2.h libngtcp2/include/ngtcp2