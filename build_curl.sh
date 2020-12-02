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

LDFLAGS="-framework Security" \
cmake -DCMAKE_USE_OPENSSL=YES \
      -DOPENSSL_ROOT_DIR="${PWD}/../../libressl" \
      -DUSE_NGHTTP2=YES \
      -DNGHTTP2_INCLUDE_DIR="${PWD}/../../nghttp2/libnghttp2/include" \
      -DNGHTTP2_LIBRARY="${PWD}/../../nghttp2/libnghttp2/lib/libnghttp2.a" \
      -DCURL_ZLIB=YES \
      -DZLIB_INCLUDE_DIR="${PWD}/../../zlib/libz/include" \
      -DZLIB_LIBRARY="${PWD}/../../zlib/libz/lib/libz.a" \
      -DUSE_LIBSSH2=YES \
      -DLIBSSH2_INCLUDE_DIR="${PWD}/../../libssh2/include" \
      -DLIBSSH2_LIBRARY="${PWD}/../../libssh2/lib/libssh2.a" \
      -DENABLE_ALT_SVC=YES \
      -DBUILD_SHARED_LIBS=NO \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -G Ninja ..

ninja && cd ..