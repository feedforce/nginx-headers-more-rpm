# What is this spec?

[Nginx](http://nginx.org) with [headers-more-module](http://wiki.nginx.org/NginxHttpHeadersMoreModule)

# Example to build SRPM and RPM

You need to install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/).

```
$ vagrant up
$ vagrant ssh
$ mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
$ (cd ~/rpmbuild/SOURCES && curl -LO http://nginx.org/download/nginx-1.7.9.tar.gz)
$ (cd ~/rpmbuild/SOURCES && curl -L -o headers-more-nginx-module-0.25.tar.gz https://github.com/openresty/headers-more-nginx-module/archive/v0.25.tar.gz)
$ cp /vagrant/{nginx.conf,nginx.init,nginx.sysconf} ~/rpmbuild/SOURCES
$ cp /vagrant/nginx.spec ~/rpmbuild/SPECS
$ sudo yum update -y
$ sudo yum install -y rpm-build
$ rpmbuild -ba ~/rpmbuild/SPECS/nginx.spec
エラー: ビルド依存性の失敗:
        gcc は nginx-1.7.9-ff1.el6.x86_64 に必要とされています
        zlib-devel は nginx-1.7.9-ff1.el6.x86_64 に必要とされています
        pcre-devel は nginx-1.7.9-ff1.el6.x86_64 に必要とされています
        openssl-devel は nginx-1.7.9-ff1.el6.x86_64 に必要とされています
$ sudo yum install -y gcc zlib-devel pcre-devel openssl-devel
$ rpmbuild -ba ~/rpmbuild/SPECS/nginx.spec
(省略)
書き込み完了: /home/vagrant/rpmbuild/SRPMS/nginx-1.7.9-ff1.el6.src.rpm
書き込み完了: /home/vagrant/rpmbuild/RPMS/x86_64/nginx-1.7.9-ff1.el6.x86_64.rpm
```

## How to build RPM from SRPM

```
$ vagrant up
$ vagrant ssh
$ sudo yum update -y
$ sudo yum install -y rpm-build
$ curl -LO https://github.com/feedforce/nginx-headers-more-rpm/releases/download/1.7.9-ff1/nginx-1.7.9-ff1.el6.src.rpm
$ rpmbuild --rebuild nginx-1.7.9-ff1.el6.src.rpm
nginx-1.7.9-ff1.el6.src.rpm をインストール中です。
エラー: ビルド依存性の失敗:
        gcc は nginx-1.7.9-ff1.el6.x86_64 に必要とされています
        zlib-devel は nginx-1.7.9-ff1.el6.x86_64 に必要とされています
        pcre-devel は nginx-1.7.9-ff1.el6.x86_64 に必要とされています
        openssl-devel は nginx-1.7.9-ff1.el6.x86_64 に必要とされています
$ sudo yum install -y gcc zlib-devel pcre-devel openssl-devel
$ rpmbuild --rebuild nginx-1.7.9-ff1.el6.src.rpm
(省略)
書き込み完了: /home/vagrant/rpmbuild/RPMS/x86_64/nginx-1.7.9-ff1.el6.x86_64.rpm
```
