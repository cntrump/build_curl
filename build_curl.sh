#!/usr/bin/env zsh

set -e

if [ ! -d curl ];then
  git clone -b curl-7_73_0 --depth=1 https://github.com/curl/curl.git
fi

cd curl

./maketgz 7.73.0 only

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

LDFLAGS="-framework Security -flto -dead_strip" \
cmake -DCMAKE_USE_OPENSSL=YES \
      -DOPENSSL_ROOT_DIR="${PWD}/../../boringssl" \
      -DUSE_NGHTTP2=YES \
      -DNGHTTP2_INCLUDE_DIR="${PWD}/../../nghttp2/libnghttp2/include" \
      -DNGHTTP2_LIBRARY="${PWD}/../../nghttp2/libnghttp2/lib/libnghttp2.a" \
      -DUSE_QUICHE=YES \
      -DQUICHE_INCLUDE_DIR="${PWD}/../../quiche/include" \
      -DQUICHE_LIBRARY="${PWD}/../../quiche/target/x86_64-apple-darwin/release/libquiche.a" \
      -DCURL_ZLIB=YES \
      -DZLIB_INCLUDE_DIR="${PWD}/../../zlib/libz/include" \
      -DZLIB_LIBRARY="${PWD}/../../zlib/libz/lib/libz.a" \
      -DCURL_ZSTD=YES \
      -DZstd_INCLUDE_DIR="${PWD}/../../zstd/libzstd/include" \
      -DZstd_LIBRARY="${PWD}/../../zstd/libzstd/lib/libzstd.a" \
      -DENABLE_ALT_SVC=YES \
      -DBUILD_SHARED_LIBS=NO \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -DCMAKE_INSTALL_PREFIX="${PWD}/../../opt" \
      -G Ninja ..

ninja

if [ -d "../../opt" ];then
  rm -rf opt
fi

ninja install

cd ../..
opt/bin/curl -V