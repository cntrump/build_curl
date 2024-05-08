#!/usr/bin/env bash

set -e

[ ! -d curl ] && git clone -b curl-8_7_1 https://github.com/curl/curl.git

[ -d build ] && rm -rf build

pushd curl
./maketgz 8.7.1 only
popd

install_prefix=$(pwd)/macosx
include_dir=${install_prefix}/include
library_dir=${install_prefix}/lib

cmake -S curl -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=$(pwd)/toolchain/xcrun.toolchain.cmake \
        -DCMAKE_INSTALL_PREFIX="${install_prefix}" \
        -DCMAKE_OSX_TRIPLE_OS=macosx \
        -DCMAKE_OSX_TRIPLE_OS_VERSION=10.9 \
        -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" \
        -DBUILD_SHARED_LIBS=OFF \
        -DCURL_USE_OPENSSL=ON -DUSE_OPENSSL_QUIC=ON \
        -DENABLE_IPV6=ON \
        -DCURL_USE_LIBPSL=OFF \
        -DCURL_DISABLE_LDAP=ON \
        -DZLIB_INCLUDE_DIR="${include_dir}" \
        -DZLIB_LIBRARY="${library_dir}/libz.a" \
        -DCURL_ZSTD=ON \
        -DZstd_INCLUDE_DIR="${include_dir}" \
        -DZstd_LIBRARY="${library_dir}/libzstd.a" \
        -DNGHTTP3_INCLUDE_DIR="${include_dir}" \
        -DNGHTTP3_LIBRARY="${library_dir}/libnghttp3.a" \
        -DOPENSSL_INCLUDE_DIR="${include_dir}" \
        -DOPENSSL_SSL_LIBRARY="${library_dir}/libssl.a" \
        -DOPENSSL_CRYPTO_LIBRARY="${library_dir}/libcrypto.a"

ninja -C build install

rm -rf build