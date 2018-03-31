################################################################################
#
# bridge-utils
#
################################################################################

BRIDGE_UTILS_VERSION = 1.6
BRIDGE_UTILS_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/net/bridge-utils
BRIDGE_UTILS_SOURCE = bridge-utils-1.6.tar.xz
BRIDGE_UTILS_AUTORECONF = YES
BRIDGE_UTILS_LICENSE = GPL-2.0+
BRIDGE_UTILS_LICENSE_FILES = COPYING

# Avoid using the host's headers. Location is not important as
# required headers will anyway be found from within the sysroot.
BRIDGE_UTILS_CONF_OPTS = --with-linux-headers=$(STAGING_DIR)/usr/include

ifeq ($(BR2_PACKAGE_BRIDGE_UTILS_HELPER_SCRIPTS),y)
ifeq ($(BR2_PACKAGE_IFUPDOWN_SCRIPTS),y)
BRIDGE_UTILS_DEPENDENCIES += ifupdown-scripts
define BRIDGE_UTILS_SUPPORT_SCRIPTS
	$(INSTALL) -d -m 755 $(TARGET_DIR)/lib/bridge-utils
	$(INSTALL) -D -m 755 $(@D)/debian/bridge-utils.sh \
		$(TARGET_DIR)/lib/bridge-utils
	$(INSTALL) -D -m 755 $(@D)/debian/ifupdown.sh \
		$(TARGET_DIR)/lib/bridge-utils
	ln -fs ../../../lib/bridge-utils/ifupdown.sh \
		$(TARGET_DIR)/etc/network/if-pre-up.d/bridge
	ln -fs ../../../lib/bridge-utils/ifupdown.sh \
		$(TARGET_DIR)/etc/network/if-post-down.d/bridge
endef

BRIDGE_UTILS_POST_INSTALL_TARGET_HOOKS += BRIDGE_UTILS_SUPPORT_SCRIPTS

endif
endif

$(eval $(autotools-package))
