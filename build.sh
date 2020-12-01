#!/usr/bin/env zsh

set -e

./build_boringssl.sh
./build_nghttp2.sh
./build_quiche.sh
#./build_nghttp3.sh
#./build_ngtcp2.sh
./build_curl.sh
