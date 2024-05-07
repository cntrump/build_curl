#!/usr/bin/env bash

set -e


version=1.3.1

if [ ! -f zlib-${version}.tar.xz ]; then
    curl -o zlib-${version}.tar.xz.curl https://www.zlib.net/zlib-${version}.tar.xz
    mv zlib-${version}.tar.xz.curl zlib-${version}.tar.xz
fi

[ -d zlib-${version} ] && rm -rf zlib-${version}

tar xvf zlib-${version}.tar.xz

[ -d build ] && rm -rf build

install_prefix=$(pwd)/macosx

cmake -S zlib-${version} -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=$(pwd)/toolchain/xcrun.toolchain.cmake \
        -DCMAKE_INSTALL_PREFIX="${install_prefix}" \
        -DCMAKE_OSX_TRIPLE_OS=macosx \
        -DCMAKE_OSX_TRIPLE_OS_VERSION=10.9 \
        -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
        -DCMAKE_CLANG_DEFINES_MODULE=ON -DCMAKE_CLANG_PRODUCT_MODULE_NAME="z" \
        -DZLIB_BUILD_EXAMPLES=OFF

ninja -C build install

rm -rf build