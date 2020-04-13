# Debian

## Building debian packages

- https://github.com/phusion/debian-packaging-for-the-modern-developer
- https://vincent.bernat.ch/en/blog/2016-pragmatic-debian-packaging
- https://www.debian.org/doc/manuals/maint-guide/

### Preparation

```
apt-get install -y devscripts gdebi-core build-essential
```

### Using dpkg-buildpackage

#### debian/control

```
Source: hello
Section: devel
Priority: optional
Maintainer: John Doe <john@doe.com>
Build-Depends: debhelper (>= 9)

Package: hello
Architecture: all
Depends: python
Description: John's hello package
           John's package is written in Python
           and prints a greeting.
           .
           It is awesome.
```

#### debian/changelog

https://www.debian.org/doc/debian-policy/ch-source.html#s-dpkgchangelog

```
hello (2.0.0-1) stretch; urgency=medium

  ,,* Initial packaging work with dpkg-buildpackage.

 -- John Doe <john@doe.com>  Thu, 06 Jul 2017 09:19:24 +0000
```

#### debian/compat

```
echo 10 > debian/compat
```

#### debian/rules

The rules file is a *Makefile*. Must contain three targets:

- *clean* -- remove all compilation products
- *build* -- compile the application
- *binary* -- create a package root directory, `debian/<source package name>`

```
#!/usr/bin/make -f

clean:
  @# Do nothing

build:
  @# Do nothing

binary:
  mkdir -p debian/hello
  mkdir -p debian/hello/usr/bin
  cp hello debian/hello/usr/bin/
  dh_gencontrol
  dh_builddeb
```

### Using debhelper

#### debian/rules

```
#!/usr/bin/make -f

PACKAGEVERSION=1.2.3

%:
  dh $@

# remove compilation products
override_dh_auto_clean:

# compile application if necessary
override_dh_auto_build:

# install application into the package root directory
override_dh_auto_install:

# override package version
override_dh_gencontrol:
  dh_gencontrol -- -v$(PACKAGEVERSION)
```

### Systemd integration

#### debian/control

```
Build-Depends: debhelper (>= 9), dh-systemd
```

#### debian/rules

```
%:
  dh $@ --with=systemd
```

#### debian/package.service

systemd service file
