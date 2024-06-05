################################################################################
#
# swtpm
#
################################################################################

SWTPM_VERSION = 0.8.2
SWTPM_SITE = $(call github,stefanberger,swtpm,v$(SWTPM_VERSION))
SWTPM_LICENSE = BSD-4-Clause
SWTPM_LICENSE_FILES = LICENSE

HOST_SWTPM_DEPENDENCIES = \
	host-json-glib \
	host-libopenssl \
	host-libtasn1 \
	host-libtool \
	host-libtpms \
	host-pkgconf

# Required because a plain Git clone is used:
HOST_SWTPM_AUTORECONF = YES

HOST_SWTPM_CONF_OPTS = \
	--disable-tests \
	--with-openssl \
	--without-seccomp

$(eval $(host-autotools-package))
