#!/usr/bin/env zsh

set -e

if [ ! -d openldap ];then
  git clone --depth=1 https://git.openldap.org/openldap/openldap.git
fi

cd openldap

export MACOSX_DEPLOYMENT_TARGET=10.9
export OPENSSL_ROOT_DIR="${PWD}/../libressl"

export CC=clang
export CXX=clang++
export CFLAGS="-I${OPENSSL_ROOT_DIR}/include -mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}"
export CPPFLAGS="${CFLAGS}"
export LDFLAGS="-L${OPENSSL_ROOT_DIR}/lib -mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}"

./configure --prefix="${PWD}/libopenldap" \
            --enable-shared=no \
            --with-tls=openssl \
            --enable-ipv6 \
            --enable-ldap \
            --enable-slapd

make -j8 depend
make -j8

if [ -d libopenldap ];then
  rm -rf libopenldap
fi

make -j8 install
make -j8 veryclean