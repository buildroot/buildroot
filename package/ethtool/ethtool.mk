################################################################################
#
# ethtool
#
################################################################################

ETHTOOL_VERSION = 6.5
ETHTOOL_SITE = https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/snapshot
# needed only for autoreconf
ETHTOOL_DEPENDENCIES = host-pkgconf
# GIT version, shipped without configure
ETHTOOL_AUTORECONF = YES
ETHTOOL_LICENSE = GPL-2.0
ETHTOOL_LICENSE_FILES = LICENSE COPYING
ETHTOOL_CPE_ID_VENDOR = kernel
ETHTOOL_CONF_OPTS = \
	$(if $(BR2_PACKAGE_ETHTOOL_PRETTY_PRINT),--enable-pretty-dump,--disable-pretty-dump)

ifeq ($(BR2_PACKAGE_LIBMNL),y)
ETHTOOL_DEPENDENCIES += host-pkgconf libmnl
ETHTOOL_CONF_OPTS += --enable-netlink
else
ETHTOOL_CONF_OPTS += --disable-netlink
endif

$(eval $(autotools-package))
