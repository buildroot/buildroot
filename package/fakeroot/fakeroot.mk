################################################################################
#
# fakeroot
#
################################################################################

FAKEROOT_VERSION = 2.1.4
FAKEROOT_SOURCE = fakeroot_$(FAKEROOT_VERSION).orig.tar.xz
FAKEROOT_SITE = https://snapshot.debian.org/archive/debian/20260711T202405Z/pool/main/f/fakeroot

HOST_FAKEROOT_DEPENDENCIES = host-acl
# Force capabilities detection off
# For now these are process capabilities (faked) rather than file
# so they're of no real use
HOST_FAKEROOT_CONF_ENV = \
	ac_cv_header_sys_capability_h=no \
	ac_cv_func_capset=no
FAKEROOT_LICENSE = GPL-3.0+
FAKEROOT_LICENSE_FILES = COPYING

# source archive does not contain pre-generated configure script
FAKEROOT_AUTORECONF = YES

$(eval $(host-autotools-package))
