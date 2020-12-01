#!/usr/bin/env zsh

if [ ! -d nghttp3 ]; then
  git clone --depth=1 https://github.com/ngtcp2/nghttp3.git
fi

cd nghttp3

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DENABLE_LIB_ONLY=YES \
      -DENABLE_STATIC_LIB=YES \
      -G Ninja  ..

ninja && cd ..

if [ -d libnghttp3 ];then
  rm -rf libnghttp3
fi

mkdir libnghttp3 && mkdir -p libnghttp3/include/nghttp3 && mkdir libnghttp3/lib

cp build/lib/libnghttp3.a libnghttp3/lib/

cp build/lib/includes/nghttp3/version.h libnghttp3/include/nghttp3
cp lib/includes/nghttp3/nghttp3.h libnghttp3/include/nghttp3