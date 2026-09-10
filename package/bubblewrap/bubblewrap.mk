################################################################################
#
# bubblewrap
#
################################################################################

BUBBLEWRAP_VERSION = 0.12.0
BUBBLEWRAP_SITE = https://github.com/containers/bubblewrap/releases/download/v$(BUBBLEWRAP_VERSION)
BUBBLEWRAP_SOURCE = bubblewrap-$(BUBBLEWRAP_VERSION).tar.xz
BUBBLEWRAP_DEPENDENCIES = host-pkgconf libcap

BUBBLEWRAP_LICENSE = LGPL-2.1+
BUBBLEWRAP_LICENSE_FILES = COPYING
BUBBLEWRAP_CPE_ID_VENDOR = projectatomic

define BUBBLEWRAP_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_USER_NS)
endef

BUBBLEWRAP_CONF_OPTS = \
	-Dassume_kernel=$(LINUX_VERSION_PROBED) \
	-Dzsh_completion=disabled \
	-Dman=disabled \
	-Dpython=$(HOST_DIR)/bin/python \
	-Dtests=false

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
BUBBLEWRAP_CONF_OPTS += \
	-Dbash_completion=enabled \
	-Dbash_completion_dir=/usr/share/bash-completion/completions
else
BUBBLEWRAP_CONF_OPTS += -Dbash_completion=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
BUBBLEWRAP_CONF_OPTS += -Dselinux=enabled
BUBBLEWRAP_DEPENDENCIES += libselinux
else
BUBBLEWRAP_CONF_OPTS += -Dselinux=disabled
endif

$(eval $(meson-package))
