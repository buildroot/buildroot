################################################################################
#
# ohnet
#
################################################################################

OHNET_VERSION = ohNet_1.13.2452
OHNET_SITE = $(call github,openhome,ohNet,$(OHNET_VERSION))
OHNET_LICENSE = MIT
OHNET_LICENSE_FILES = License.txt MitLicense.txt

# static libraries only
OHNET_INSTALL_STAGING = YES
OHNET_INSTALL_TARGET = NO

HOST_OHNET_DEPENDENCIES = host-mono

OHNET_MAKE_OPTS = \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CROSS_LINKFLAGS="$(TARGET_LDFLAGS)"

HOST_OHNET_MAKE_OPTS = uset4=yes

# parallel build issues, therefore needs MAKE1
define OHNET_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) $(OHNET_MAKE_OPTS) \
		ohNetCore ohNet TestFramework
endef

define HOST_OHNET_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(HOST_OHNET_MAKE_OPTS) tt
endef

define OHNET_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(OHNET_MAKE_OPTS) \
		prefix="$(STAGING_DIR)/usr" install
endef

define HOST_OHNET_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/usr/share/ohNet/Build
	cp -dpfr $(@D)/Build/Tools $(HOST_DIR)/usr/share/ohNet/Build/Tools
	mkdir -p $(HOST_DIR)/usr/share/ohNet/OpenHome/Net/T4/Templates
	cp -dpfr $(@D)/OpenHome/Net/T4/Templates \
		$(HOST_DIR)/usr/share/ohNet/OpenHome/Net/T4
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
