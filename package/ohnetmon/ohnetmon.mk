################################################################################
#
# ohnetmon
#
################################################################################

OHNETMON_VERSION = ohNetmon_1.0.33
OHNETMON_SITE = $(call github,openhome,ohNetmon,$(OHNETMON_VERSION))
OHNETMON_LICENSE = BSD-2c
OHNETMON_LICENSE_FILES = License.txt BsdLicense.txt
OHNETMON_DEPENDENCIES = ohnet host-ohnet host-ohdevtools
OHNETMON_INSTALL_STAGING = YES

# bundled waf does not support --libdir
OHNETMON_NEEDS_EXTERNAL_WAF = YES

define OHNETMON_FETCH_OHWAFHELPERS
	OHDEVTOOLS_ROOT=$(OHDEVTOOLS_ROOT) $(@D)/go fetch ohWafHelpers
endef
OHNETMON_PRE_CONFIGURE_HOOKS += OHNETMON_FETCH_OHWAFHELPERS

ifeq ($(BR2_i386),y)
OHNETMON_CPU = x86
else ifeq ($(BR2_x86_64),y)
OHNETMON_CPU = x64
else ifeq ($(BR2_mips)$(BR2_mipsel),y)
OHNETMON_CPU = mipsel
else ifeq ($(BR2_arm),y)
ifeq ($(BR2_ARM_EABIHF),y)
OHNETMON_CPU = armhf
else
OHNETMON_CPU = ARM
endif
ifeq ($(BR2_powerpc),y)
OHNETMON_CPU = ppc32
endif
endif

OHNETMON_CONF_OPTS = \
	--cross="$(TARGET_CROSS)" \
	--dest-platform=Linux-$(OHNETMON_CPU) \
	--ohnet-include-dir=$(STAGING_DIR)/usr/include/ohNet \
	--ohnet-lib-dir=$(STAGING_DIR)/usr/lib/ohNet \
	--ohnet=$(HOST_DIR)/usr/share/ohNet

define OHNETMON_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/OpenHome/NetworkMonitor.h \
		$(STAGING_DIR)/usr/include/OpenHome/NetworkMonitor.h
	$(INSTALL) -D -m 0644 $(@D)/build/libohNetmon.a \
		$(STAGING_DIR)/usr/lib/ohNetmon/libohNetmon.a
endef

$(eval $(waf-package))
