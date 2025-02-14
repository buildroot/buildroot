################################################################################
#
# fakeroot
#
################################################################################

FAKEROOT_VERSION = 1.36
FAKEROOT_SOURCE = fakeroot_$(FAKEROOT_VERSION).orig.tar.gz
FAKEROOT_SITE = https://snapshot.debian.org/archive/debian/20241022T144244Z/pool/main/f/fakeroot/

HOST_FAKEROOT_DEPENDENCIES = host-acl
# Force capabilities detection off
# For now these are process capabilities (faked) rather than file
# so they're of no real use
HOST_FAKEROOT_CONF_ENV = \
	ac_cv_header_sys_capability_h=no \
	ac_cv_func_capset=no
# 0001-Makefile.am-fix-parallel-build.patch
HOST_FAKEROOT_AUTORECONF = YES
FAKEROOT_LICENSE = GPL-3.0+
FAKEROOT_LICENSE_FILES = COPYING

$(eval $(host-autotools-package))
