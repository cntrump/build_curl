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
      -G Ninja  ..

ninja && cd ..

if [ -d libnghttp2 ];then
  rm -rf libnghttp2
fi

mkdir libnghttp2 && mkdir -p libnghttp2/include/nghttp2 && mkdir libnghttp2/lib

cp build/lib/libnghttp2.a libnghttp2/lib/

cp build/lib/includes/nghttp2/nghttp2ver.h libnghttp2/include/nghttp2
cp lib/includes/nghttp2/nghttp2.h libnghttp2/include/nghttp2