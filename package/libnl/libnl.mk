################################################################################
#
# libnl
#
################################################################################

LIBNL_VERSION = 3.2.27
LIBNL_SITE = https://github.com/thom311/libnl/releases/download/libnl$(subst .,_,$(LIBNL_VERSION))
LIBNL_LICENSE = LGPLv2.1+
LIBNL_LICENSE_FILES = COPYING
LIBNL_INSTALL_STAGING = YES
LIBNL_DEPENDENCIES = host-bison host-flex

LIBNL_PATCH = https://github.com/thom311/libnl/commit/3e18948f17148e6a3c4255bdeaaf01ef6081ceeb.patch

ifeq ($(BR2_PACKAGE_LIBNL_TOOLS),y)
LIBNL_CONF_OPTS += --enable-cli
else
LIBNL_CONF_OPTS += --disable-cli
endif

$(eval $(autotools-package))
