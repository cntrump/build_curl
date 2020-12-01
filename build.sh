#!/usr/bin/env zsh

set -e

./build_boringssl.sh
./build_nghttp2.sh
./build_quiche.sh
./build_curl.sh
