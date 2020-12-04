#!/usr/bin/env zsh

set -e

export CC="clang"
export CXX="clang++"
export CFLAGS="-flto"
export CXXFLAGS="${CFLAGS}"

./build_zlib.sh
./build_zstd.sh
./build_boringssl.sh
./build_nghttp2.sh
./build_quiche.sh
./build_curl.sh
