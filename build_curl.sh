#!/usr/bin/env zsh

set -e

if [ ! -d curl ];then
  git clone -b curl-7_73_0 --depth=1 https://github.com/curl/curl.git
fi

cd curl && ./maketgz 7.73.0 only

sed -i "" "s/static CURLcode ldap_connect(/static CURLcode ldap_connect_s(/g" lib/openldap.c

if [ -d build ];then
  rm -rf build
fi

mkdir build && cd build

LDFLAGS="-lldap -lsasl2" \
cmake -DCMAKE_USE_OPENSSL=YES \
      -DOPENSSL_ROOT_DIR="${PWD}/../../libressl" \
      -DUSE_NGHTTP2=YES \
      -DNGHTTP2_INCLUDE_DIR="${PWD}/../../nghttp2/libnghttp2/include" \
      -DNGHTTP2_LIBRARY="${PWD}/../../nghttp2/libnghttp2/lib/libnghttp2.a" \
      -DCURL_ZLIB=YES \
      -DZLIB_INCLUDE_DIR="${PWD}/../../zlib/libz/include" \
      -DZLIB_LIBRARY="${PWD}/../../zlib/libz/lib/libz.a" \
      -DUSE_LIBSSH2=YES \
      -DLIBSSH2_INCLUDE_DIR="${PWD}/../../ssh2/include" \
      -DLIBSSH2_LIBRARY="${PWD}/../../ssh2/lib/libssh2.a" \
      -DCURL_DISABLE_LDAP=NO -DCURL_DISABLE_LDAPS=NO -DCMAKE_USE_OPENLDAP=YES \
      -DCMAKE_LDAP_INCLUDE_DIR="${PWD}/../../openldap/libopenldap/include" \
      -DCMAKE_LDAP_LIB="${PWD}/../../openldap/libopenldap/lib/libldap.a" \
      -DCMAKE_LBER_LIB="${PWD}/../../openldap/libopenldap/lib/liblber.a" \
      -DENABLE_ALT_SVC=YES \
      -DBUILD_SHARED_LIBS=NO \
      -DCMAKE_OSX_SYSROOT=macosx -DCMAKE_OSX_DEPLOYMENT_TARGET=10.9 \
      -DCMAKE_INSTALL_PREFIX="${PWD}/../../opt" \
      -G Ninja ..

ninja

if [ -d "../../opt" ];then
  rm -rf opt
fi

ninja install

cd ../..
opt/bin/curl -V