#!/usr/bin/env bash

set -e

if [ ! -d nghttp3 ]; then
  git clone -b v1.2.0 https://github.com/ngtcp2/nghttp3.git
  pushd nghttp3
  git submodule update --init
  popd
fi

[ -d build ] && rm -rf build

install_prefix=$(pwd)/macosx

cmake -S nghttp3 -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=$(pwd)/toolchain/xcrun.toolchain.cmake \
        -DCMAKE_INSTALL_PREFIX="${install_prefix}" \
        -DCMAKE_OSX_TRIPLE_OS=macosx \
        -DCMAKE_OSX_TRIPLE_OS_VERSION=10.9 \
        -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
        -DCMAKE_CLANG_DEFINES_MODULE=ON -DCMAKE_CLANG_PRODUCT_MODULE_NAME="nghttp3" \
        -DENABLE_LIB_ONLY=ON \
        -DENABLE_SHARED_LIB=OFF \
        -DENABLE_STATIC_LIB=ON

ninja -C build install

rm -rf build