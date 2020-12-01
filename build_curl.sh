#!/usr/bin/env zsh

set -e

if [ ! -d curl ];then
  git clone -b curl-7_73_0 --depth=1 https://github.com/curl/curl.git
fi

cd curl

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DCMAKE_USE_OPENSSL=YES \
      -DOPENSSL_ROOT_DIR=../boringssl \
      -DUSE_NGHTTP2=YES \
      -DNGHTTP2_INCLUDE_DIR=../../nghttp2/libnghttp2/include \
      -DNGHTTP2_LIBRARY=../../nghttp2/libnghttp2/lib/libnghttp2.a \
      -DUSE_NGTCP2=YES \
      -DNGTCP2_INCLUDE_DIR=../../ngtcp2/libngtcp2/include \
      -DNGTCP2_LIBRARY=../../ngtcp2/libngtcp2/lib/libngtcp2.a \
      -DLIBNGHTTP3_INCLUDE_DIR=../../nghttp3/libnghttp3/include \
      -DLIBNGHTTP3_LIBRARY=../../nghttp3/libnghttp3/lib/libnghttp3.a \
      -DBUILD_SHARED_LIBS=NO \
      -G Ninja ..

ninja && cd ..