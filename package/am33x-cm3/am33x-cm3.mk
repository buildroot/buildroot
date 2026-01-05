################################################################################
#
# am33x-cm3
#
################################################################################

# This should correspond to version 0x192
AM33X_CM3_VERSION = fb484c5e54f2e31cf0a338d2927a06a2870bcc2c
AM33X_CM3_SITE = https://git.ti.com/git/processor-firmware/ti-amx3-cm3-pm-firmware.git
AM33X_CM3_SITE_METHOD = git
AM33X_CM3_LICENSE = TI Publicly Available Software License
AM33X_CM3_LICENSE_FILES = License.txt

# The build command below will use the standard cross-compiler (normally
# build for Cortex-A8, to build the FW for the Cortex-M3.
define AM33X_CM3_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D) all
endef

define AM33X_CM3_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 -D $(@D)/bin/am335x-pm-firmware.elf \
		$(TARGET_DIR)/lib/firmware/am335x-pm-firmware.elf
	$(INSTALL) -m 0644 -D $(@D)/bin/*-scale-data.bin \
		$(TARGET_DIR)/lib/firmware/
endef

$(eval $(generic-package))
