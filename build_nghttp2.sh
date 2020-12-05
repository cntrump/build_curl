#!/usr/bin/env zsh

if [ ! -d nghttp2 ]; then
  git clone -b v1.42.0 --depth=1 https://github.com/nghttp2/nghttp2.git
fi

cd nghttp2

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DENABLE_LIB_ONLY=YES \
      -DENABLE_STATIC_LIB=YES \
      -DOPENSSL_ROOT_DIR="${PWD}/../../libressl/opt" \
      -DOPENSSL_USE_STATIC_LIBS=YES \
      -DZLIB_INCLUDE_DIR="${PWD}/../../zlib/libz/include" \
      -DZLIB_LIBRARY="${PWD}/../../zlib/libz/lib/libz.a" \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -G Ninja  ..

ninja && cd ..

if [ -d libnghttp2 ];then
  rm -rf libnghttp2
fi

mkdir libnghttp2 && cd libnghttp2

mkdir -p include/nghttp2 && mkdir lib

cd lib
ln -s ../../build/lib/libnghttp2.a libnghttp2.a
cd ..

cd include/nghttp2
ln -s ../../../build/lib/includes/nghttp2/nghttp2ver.h nghttp2ver.h
ln -s ../../../lib/includes/nghttp2/nghttp2.h nghttp2.h
cd ../..