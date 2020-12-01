#!/usr/bin/env zsh

if [ ! -d boringssl ]; then
  git clone --depth=1 https://github.com/google/boringssl.git
fi

cd boringssl

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=0 \
      -G Ninja  ..

ninja && cd ..

if [ -d lib ];then
  rm -rf lib
fi

mkdir lib

cp build/crypto/libcrypto.a lib/libcrypto.a
cp build/ssl/libssl.a lib/libssl.a