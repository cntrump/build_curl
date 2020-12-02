#!/usr/bin/env zsh

set -e

if [ ! -d quiche ];then
  git clone -b 0.6.0 --depth=1 https://github.com/cloudflare/quiche
fi

cd quiche

if [ -d target ];then
  cargo clean
fi

export MACOSX_DEPLOYMENT_TARGET=10.9

QUICHE_BSSL_PATH="${PWD}/../boringssl" \
cargo build --target=x86_64-apple-darwin --lib --release --features pkg-config-meta,qlog --verbose

cd ..