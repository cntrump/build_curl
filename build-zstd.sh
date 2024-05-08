#!/usr/bin/env bash

set -e

[ ! -d zstd ] && git clone -b v1.5.6 https://github.com/facebook/zstd.git

[ -d build ] && rm -rf build

install_prefix=$(pwd)/macosx

cmake -S zstd/build/cmake -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=$(pwd)/toolchain/xcrun.toolchain.cmake \
        -DCMAKE_INSTALL_PREFIX="${install_prefix}" \
        -DCMAKE_OSX_TRIPLE_OS=macosx \
        -DCMAKE_OSX_TRIPLE_OS_VERSION=10.9 \
        -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
        -DZSTD_BUILD_SHARED=OFF \
        -DZSTD_BUILD_PROGRAMS=OFF -DZSTD_BUILD_TESTS=OFF

ninja -C build install

rm -rf build