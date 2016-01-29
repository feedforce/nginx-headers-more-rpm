#!/bin/sh

set -xe

CENTOS_MAJOR_VERSION=$(rpm -q --qf '%{VERSION}' $(rpm -q --whatprovides redhat-release))

PATCH_PATH=$HOME/nginx.spec.centos${CENTOS_MAJOR_VERSION}.patch

NGINX_VERSION=$(grep '^ Version:' $PATCH_PATH | cut -d ' ' -f 3)

HEADERS_MORE_VERSION=$(grep 'headers-more-nginx-module-.*\.tar\.gz' $PATCH_PATH | \
                         cut -d ' ' -f 2 | \
                         sed -e 's@headers-more-nginx-module-\([0-9]\+\)\.\([0-9]\+\)\.tar\.gz@\1.\2@')

NGINX_RPM_FILE=nginx-${NGINX_VERSION}-1.el${CENTOS_MAJOR_VERSION}.ngx.src.rpm
curl -LO http://nginx.org/packages/centos/${CENTOS_MAJOR_VERSION}/SRPMS/${NGINX_RPM_FILE}
rpm -Uvh $NGINX_RPM_FILE

cd $HOME/rpmbuild/SOURCES
curl -L -o headers-more-nginx-module-${HEADERS_MORE_VERSION}.tar.gz \
  https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERS_MORE_VERSION}.tar.gz

cd $HOME/rpmbuild/SPECS
patch -p0 < $PATCH_PATH
rpmbuild -ba nginx.spec

cp $HOME/rpmbuild/RPMS/x86_64/* /shared
