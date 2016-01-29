# What is this repository?

[Nginx](http://nginx.org) with [headers-more-module](http://wiki.nginx.org/NginxHttpHeadersMoreModule)

You can build RPM with headers-more-module using the official SRPM.

# How to build RPM?

1. Create your feature branch(e.g nginx-1.8.0)
2. Update 2 files according to the methods described below
    - nginx.spec.centos6.patch
    - nginx.spec.centos7.patch
3. Push to the branch
4. Create a Pull request
5. When the Pull request is merged, CircleCI will release nginx rpms to https://github.com/feedforce/nginx-headers-more-rpm/releases

# How to update nginx.spec.centos[67].patch?

### Requirement

* rpm2cpio

    ```
    # OSX
    $ brew install rpm2cpio
    ```

### CentOS6

```
$ curl -LO http://nginx.org/packages/centos/6/SRPMS/nginx-1.8.0-1.el6.ngx.src.rpm
$ rpm2cpio.pl nginx-1.8.0-1.el6.ngx.src.rpm | cpio -idv nginx.spec
$ cp nginx.spec nginx.spec.org
$ patch -p0 < nginx.spec.centos6.patch
    patching file nginx.spec
    Hunk #1 FAILED at 59.
    Hunk #9 FAILED at 345.

# Modify as below using your favorite editor.
#   Fix `Release:`
#   Add `Packager:`
#   Add your changelog to `%changelog`
#   Update headers-more-nginx-module version if needed

$ diff -u nginx.spec.org nginx.spec >! nginx.spec.centos6.patch
```

### CentOS7

```
$ curl -LO http://nginx.org/packages/centos/7/SRPMS/nginx-1.8.0-1.el7.ngx.src.rpm
$ rpm2cpio.pl nginx-1.8.0-1.el7.ngx.src.rpm | cpio -idv nginx.spec
$ cp nginx.spec nginx.spec.org
$ patch -p0 < nginx.spec.centos7.patch
    patching file nginx.spec
    Hunk #1 FAILED at 59.
    Hunk #9 FAILED at 345.

# Modify as below using your favorite editor.
#   Fix `Release:`
#   Add `Packager:`
#   Add your changelog to `%changelog`
#   Update headers-more-nginx-module version if needed

$ diff -u nginx.spec.org nginx.spec >! nginx.spec.centos7.patch
```
