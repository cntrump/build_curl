#!/usr/bin/env zsh

set -e

if [ ! -d zstd ];then
  git clone -b v1.4.5 --depth=1 https://github.com/facebook/zstd.git
fi

cd zstd/build/cmake

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DCMAKE_BUILD_TYPE=Release \
      -DZSTD_BUILD_STATIC=YES \
      -DZSTD_BUILD_TESTS=NO -DZSTD_BUILD_PROGRAMS=NO -DZSTD_BUILD_SHARED=NO \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -G Ninja  ..

ninja && cd ../../..

if [ -d libzstd ];then
  rm -rf libzstd
fi

mkdir libzstd && cd libzstd

mkdir include && mkdir lib

cd lib
ln -s ../../build/cmake/build/lib/libzstd.a libzstd.a
cd ..

cd include
ln -s ../../lib/zstd.h zstd.h
cd ..
