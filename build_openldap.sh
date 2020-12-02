#!/usr/bin/env zsh

set -e

if [ ! -d openldap ];then
  git clone -b OPENLDAP_REL_ENG_2_4_56 --depth=1 https://git.openldap.org/openldap/openldap.git
fi

cd openldap
