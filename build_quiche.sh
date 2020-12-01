#!/usr/bin/env zsh

set -e

if [ ! -d quiche ];then
  git clone -b 0.6.0 --depth=1 --recursive https://github.com/cloudflare/quiche
fi

cd quiche

cargo build --release --features pkg-config-meta,qlog

cd ..