################################################################################
#
# libnids
#
################################################################################

LIBNIDS_VERSION = 1.24
LIBNIDS_SITE = https://sourceforge.net/projects/libnids/files/libnids/$(LIBNIDS_VERSION)
LIBNIDS_LICENSE = GPL-2.0
LIBNIDS_LICENSE_FILES = COPYING
LIBNIDS_INSTALL_STAGING = YES
LIBNIDS_DEPENDENCIES = host-pkgconf libpcap
LIBNIDS_AUTORECONF = YES
LIBNIDS_CONF_OPTS = \
	--disable-libglib \
	--disable-libnet
# hand-written Makefile.in, not using automake, needs a custom
# variable for the installation path.
LIBNIDS_INSTALL_STAGING_OPTS = install_prefix=$(STAGING_DIR) install
LIBNIDS_INSTALL_TARGET_OPTS = install_prefix=$(TARGET_DIR) install

$(eval $(autotools-package))
