################################################################################
#
# bcusdk
#
################################################################################

BCUSDK_VERSION = 0.0.5
BCUSDK_SOURCE = bcusdk_$(BCUSDK_VERSION).tar.gz
BCUSDK_SITE = http://www.auto.tuwien.ac.at/~mkoegler/eib
BCUSDK_LICENSE = GPL-2.0+
BCUSDK_LICENSE_FILES = COPYING
BCUSDK_INSTALL_STAGING = YES
# 0003-m4-ccforbuild.m4-include-stdlib.h-in-test-program.patch
# 0004-configure.in-replace-obsolete-AM_PATH_XML2-by-PKG_CH.patch
BCUSDK_AUTORECONF = YES
BCUSDK_CONF_OPTS = \
	--enable-onlyeibd \
	--enable-ft12 \
	--enable-pei16 \
	--enable-tpuarts \
	--enable-eibnetip \
	--enable-eibnetipserver \
	--enable-eibnetiptunnel \
	--without-pth-test \
	--with-pth=$(STAGING_DIR)/usr

# host-pkgconf is only needed because of autoreconf
BCUSDK_DEPENDENCIES = libpthsem host-pkgconf

ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
BCUSDK_DEPENDENCIES += argp-standalone $(TARGET_NLS_DEPENDENCIES)
BCUSDK_CONF_ENV += LIBS=$(TARGET_NLS_LIBS)
endif

define BCUSDK_REMOVE_EXAMPLES
	$(RM) -rf $(TARGET_DIR)/usr/share/bcusdk
endef

BCUSDK_POST_INSTALL_TARGET_HOOKS += BCUSDK_REMOVE_EXAMPLES

$(eval $(autotools-package))
