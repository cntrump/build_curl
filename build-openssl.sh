#!/usr/bin/env bash

set -e

[ ! -d openssl ] && git clone --depth=1 -b openssl-3.3.0 https://github.com/openssl/openssl.git

cp -f openssl-apple/15-apple-universal.conf openssl/Configurations/15-apple-universal.conf

install_prefix=$(pwd)/macosx

pushd openssl

./Configure apple-universal-macosx enable-tls1_3 no-apps no-tests no-shared --prefix="${install_prefix}"
make clean
make -j
make install_sw

popd