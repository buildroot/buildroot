################################################################################
#
# dhcpdump
#
################################################################################

DHCPDUMP_VERSION = 1.9
DHCPDUMP_SOURCE = dhcpdump-$(DHCPDUMP_VERSION).tar.xz
DHCPDUMP_SITE = https://github.com/bbonev/dhcpdump/releases/download/v$(DHCPDUMP_VERSION)
DHCPDUMP_DEPENDENCIES = libpcap
DHCPDUMP_LICENSE = BSD-2-Clause
DHCPDUMP_LICENSE_FILES = LICENSE

DHCPDUMP_LIBS = -lpcap
ifeq ($(BR2_STATIC_LIBS),y)
DHCPDUMP_LIBS += `$(STAGING_DIR)/usr/bin/pcap-config --static --additional-libs`
endif

define DHCPDUMP_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
		LDFLAGS="$(TARGET_LDFLAGS)" LIBS="$(DHCPDUMP_LIBS)" dhcpdump
endef

define DHCPDUMP_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/dhcpdump $(TARGET_DIR)/usr/bin/dhcpdump
endef

$(eval $(generic-package))
