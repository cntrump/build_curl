#!/usr/bin/env zsh

set -e

if [ ! -d quiche ];then
  git clone -b 0.6.0 --depth=1 --recursive https://github.com/cloudflare/quiche
fi

cd quiche

if [ -d target ];then
  cargo clean
fi

MACOSX_DEPLOYMENT_TARGET=10.9 \
cargo build --target=x86_64-apple-darwin --release --features pkg-config-meta,qlog --verbose

cd ..