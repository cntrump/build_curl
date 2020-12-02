#!/usr/bin/env zsh

set -e

if [ ! -d zlib ];then
  git clone -b v1.2.11 --depth=1 https://github.com/madler/zlib.git
fi

cd zlib

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DSKIP_INSTALL_ALL=YES \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -G Ninja ..

ninja && cd ..

if [ -d libz ];then
  rm -rf libz
fi

mkdir libz && cd libz

mkdir include && mkdir lib

cd lib
ln -s ../../build/libz.a libz.a
cd ..

cd include
ln -s ../../build/zconf.h zconf.h
ln -s ../../zlib.h zlib.h
cd ..