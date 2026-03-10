################################################################################
#
# ndctl
#
################################################################################

NDCTL_VERSION = 83
NDCTL_SITE = $(call github,pmem,ndctl,v$(NDCTL_VERSION))
NDCTL_LICENSE = \
	CC0-1.0 (helper routines), \
	GPL-2.0+ (tools), \
	LGPL-2.1+ (libraries), \
	MIT (helper routines)
NDCTL_LICENSE_FILES = \
	COPYING \
	LICENSES/other/CC0-1.0 \
	LICENSES/other/MIT \
	LICENSES/preferred/GPL-2.0 \
	LICENSES/preferred/LGPL-2.1

NDCTL_DEPENDENCIES = \
	iniparser \
	json-c \
	keyutils \
	kmod \
	udev \
	util-linux-libs

# Currently, disabling keyutils or fwctl support will cause builds to
# fail. Therefore, always pass the -Dfwctl=enabled and -Dkeyutils=enabled.
NDCTL_CONF_OPTS = \
	-Ddocs=disabled \
	-Dfwctl=enabled \
	-Dkeyutils=enabled \
	-Diniparserdir=$(STAGING_DIR)/usr/include/iniparser

ifeq ($(BR2_PACKAGE_LIBTRACEFS)$(BR2_PACKAGE_LIBTRACEEVENT),yy)
NDCTL_CONF_OPTS += -Dlibtracefs=enabled
NDCTL_DEPENDENCIES += libtraceevent libtracefs
else
NDCTL_CONF_OPTS += -Dlibtracefs=disabled
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
NDCTL_CONF_OPTS += -Dsystemd=enabled
NDCTL_DEPENDENCIES += systemd
else
NDCTL_CONF_OPTS += -Dsystemd=disabled
endif

$(eval $(meson-package))
