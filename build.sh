#!/usr/bin/env zsh

set -e

export CC=clang
export CXX=clang++

./build_zlib.sh
./build_libressl.sh
./build_ssh2.sh
./build_nghttp2.sh
./build_curl.sh
