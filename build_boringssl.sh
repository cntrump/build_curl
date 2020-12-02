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
      -DBUILD_SHARED_LIBS=NO \
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