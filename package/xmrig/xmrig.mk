################################################################################
#
# xmrig
#
################################################################################

XMRIG_VERSION = 6.14.1
XMRIG_SITE = $(call github,xmrig,xmrig,v$(XMRIG_VERSION))
XMRIG_LICENSE = GPL-3.0+
XMRIG_LICENSE_FILES = LICENSE
XMRIG_DEPENDENCIES = libuv
XMRIG_CONF_OPTS = -DWITH_CUDA=OFF

ifeq ($(BR2_PACKAGE_HAS_LIBOPENCL),y)
XMRIG_CONF_OPTS += -DWITH_OPENCL=ON
XMRIG_DEPENDENCIES += libopencl
else
XMRIG_CONF_OPTS += -DWITH_OPENCL=OFF
endif

ifeq ($(BR2_PACKAGE_HWLOC),y)
XMRIG_CONF_OPTS += -DWITH_HWLOC=ON
XMRIG_DEPENDENCIES += hwloc
else
XMRIG_CONF_OPTS += -DWITH_HWLOC=OFF
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
XMRIG_CONF_OPTS += -DWITH_TLS=ON
XMRIG_DEPENDENCIES += openssl
else
XMRIG_CONF_OPTS += -DWITH_TLS=OFF
XMRIG_SUFFIX = -notls
endif

# Upstream provides no installation rule:
#   *** No rule to make target 'install/fast'.  Stop.
define XMRIG_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/xmrig$(XMRIG_SUFFIX) \
		$(TARGET_DIR)/usr/bin/xmrig$(XMRIG_SUFFIX)
endef

$(eval $(cmake-package))
