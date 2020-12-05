#!/usr/bin/env zsh

set -e

if [ ! -d ssh2 ];then
  git clone -b libssh2-1.9.0 --depth=1 https://github.com/libssh2/libssh2.git ssh2
fi

cd ssh2

sed -i "" "s/sed -i /sed -i\"\" /g" ./maketgz
./maketgz 1.9.0 only

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

cmake -DOPENSSL_ROOT_DIR="${PWD}/../../libressl" \
      -DBUILD_EXAMPLES=NO -DBUILD_TESTING=NO \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -G Ninja  ..

ninja && cd ..

if [ -d lib ];then
  rm -rf lib
fi

mkdir lib && cd lib

ln -s ../build/src/libssh2.a libssh2.a