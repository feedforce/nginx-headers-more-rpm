# What is this spec?

[Nginx](http://nginx.org) with [headers-more-module](http://wiki.nginx.org/NginxHttpHeadersMoreModule)

You can build SRPM and RPM with headers-more-module using the official SRPM.

You need to install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/).

# How to update nginx.spec.centos[67].patch?

### CentOS7

```
$ vagrant up centos7
$ vagrant ssh centos7
$ sudo yum update -y
$ sudo yum install -y rpm-build gcc
$ curl -LO http://nginx.org/packages/centos/7/SRPMS/nginx-1.8.0-1.el7.ngx.src.rpm
$ rpm -Uvh nginx-1.8.0-1.el7.ngx.src.rpm
$ cd ~/rpmbuild/SPECS
$ cp nginx.spec nginx.spec.org
$ patch -p0 < /vagrant/nginx.spec.centos7.patch
    patching file nginx.spec
    Hunk #1 FAILED at 59.
    Hunk #9 FAILED at 345.
# Fix `Release:`
# Add `Packager:`
# Add your changelog to `%changelog`
# Update headers-more-nginx-module version if needed
$ vi nginx.spec
$ diff -u nginx.spec.org nginx.spec > /vagrant/nginx.spec.centos7.patch
```

### CentOS6

```
$ vagrant up centos6
$ vagrant ssh centos6
$ sudo yum update -y
$ sudo yum install -y rpm-build gcc
$ curl -LO http://nginx.org/packages/centos/6/SRPMS/nginx-1.8.0-1.el6.ngx.src.rpm
$ rpm -Uvh nginx-1.8.0-1.el6.ngx.src.rpm
$ cd ~/rpmbuild/SPECS
$ cp nginx.spec nginx.spec.org
$ patch -p0 < /vagrant/nginx.spec.centos6.patch
    patching file nginx.spec
    Hunk #1 FAILED at 59.
    Hunk #9 FAILED at 345.
# Fix `Release:`
# Add `Packager:`
# Add your changelog to `%changelog`
# Update headers-more-nginx-module version if needed
$ vi nginx.spec
$ diff -u nginx.spec.org nginx.spec > /vagrant/nginx.spec.centos6.patch
```

# How to build SRPM and RPM?

### CentOS7

```
$ vagrant up centos7
$ vagrant ssh centos7
$ sudo yum update -y
$ sudo yum install -y rpm-build gcc
$ curl -LO http://nginx.org/packages/centos/7/SRPMS/nginx-1.8.0-1.el7.ngx.src.rpm
$ rpm -Uvh nginx-1.8.0-1.el7.ngx.src.rpm
$ cd ~/rpmbuild/SOURCES
$ curl -L -o headers-more-nginx-module-0.26.tar.gz https://github.com/openresty/headers-more-nginx-module/archive/v0.26.tar.gz
$ cd ~/rpmbuild/SPECS
$ patch -p0 < /vagrant/nginx.spec.centos7.patch
$ rpmbuild -ba nginx.spec
エラー: ビルド依存性の失敗:
    openssl-devel >= 1.0.1 は nginx-1:1.8.0-ff1.el7.centos.ngx.x86_64 に必要とされています
    zlib-devel は nginx-1:1.8.0-ff1.el7.centos.ngx.x86_64 に必要とされています
    pcre-devel は nginx-1:1.8.0-ff1.el7.centos.ngx.x86_64 に必要とされています
$ sudo yum install -y openssl-devel zlib-devel pcre-devel
$ rpmbuild -ba nginx.spec
(省略)
書き込み完了: /home/vagrant/rpmbuild/SRPMS/nginx-1.8.0-ff1.el7.centos.ngx.src.rpm
書き込み完了: /home/vagrant/rpmbuild/RPMS/x86_64/nginx-1.8.0-ff1.el7.centos.ngx.x86_64.rpm
書き込み完了: /home/vagrant/rpmbuild/RPMS/x86_64/nginx-debug-1.8.0-ff1.el7.centos.ngx.x86_64.rpm
書き込み完了: /home/vagrant/rpmbuild/RPMS/x86_64/nginx-debuginfo-1.8.0-ff1.el7.centos.ngx.x86_64.rpm
```

### CentOS6

```
$ vagrant up centos6
$ vagrant ssh centos6
$ sudo yum update -y
$ sudo yum install -y rpm-build gcc
$ curl -LO http://nginx.org/packages/centos/6/SRPMS/nginx-1.8.0-1.el6.ngx.src.rpm
$ rpm -Uvh nginx-1.8.0-1.el6.ngx.src.rpm
$ cd ~/rpmbuild/SOURCES
$ curl -L -o headers-more-nginx-module-0.26.tar.gz https://github.com/openresty/headers-more-nginx-module/archive/v0.26.tar.gz
$ cd ~/rpmbuild/SPECS
$ patch -p0 < /vagrant/nginx.spec.centos6.patch
$ rpmbuild -ba nginx.spec
エラー: ビルド依存性の失敗:
    openssl-devel >= 1.0.1 は nginx-1.8.0-ff1.el6.ngx.x86_64 に必要とされています
    zlib-devel は nginx-1.8.0-ff1.el6.ngx.x86_64 に必要とされています
    pcre-devel は nginx-1.8.0-ff1.el6.ngx.x86_64 に必要とされています
$ sudo yum install -y openssl-devel zlib-devel pcre-devel
$ rpmbuild -ba nginx.spec
(省略)
書き込み完了: /home/vagrant/rpmbuild/SRPMS/nginx-1.8.0-ff1.el6.ngx.src.rpm
書き込み完了: /home/vagrant/rpmbuild/RPMS/x86_64/nginx-1.8.0-ff1.el6.ngx.x86_64.rpm
書き込み完了: /home/vagrant/rpmbuild/RPMS/x86_64/nginx-debug-1.8.0-ff1.el6.ngx.x86_64.rpm
```
