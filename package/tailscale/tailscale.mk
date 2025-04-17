################################################################################
#
# tailscale
#
################################################################################

TAILSCALE_VERSION = 1.78.1
TAILSCALE_SITE = $(call github,tailscale,tailscale,v$(TAILSCALE_VERSION))
TAILSCALE_LICENSE = BSD-3-Clause
TAILSCALE_LICENSE_FILES = LICENSE
TAILSCALE_GOMOD = tailscale.com
TAILSCALE_BUILD_TARGETS = cmd/tailscale cmd/tailscaled
TAILSCALE_INSTALL_BINS = tailscale tailscaled
TAILSCALE_LDFLAGS = \
	-X tailscale.com/version.longStamp=$(TAILSCALE_VERSION) \
	-X tailscale.com/version.shortStamp=$(TAILSCALE_VERSION)

define TAILSCALE_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/cmd/tailscaled/tailscaled.defaults \
		$(TARGET_DIR)/etc/default/tailscaled
	$(INSTALL) -D -m 0644 $(@D)/cmd/tailscaled/tailscaled.service \
		$(TARGET_DIR)/usr/lib/systemd/system/tailscaled.service
endef

define TAILSCALE_INSTALL_SYMLINK
	ln -f -s ../bin/tailscaled $(TARGET_DIR)/usr/sbin/tailscaled
endef
TAILSCALE_POST_INSTALL_TARGET_HOOKS += TAILSCALE_INSTALL_SYMLINK

define TAILSCALE_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_TUN)
endef

$(eval $(golang-package))
