################################################################################
#
# edk2-non-osi
#
################################################################################

# Keep in sync with latest commit as of the release date for boot/edk2
EDK2_NON_OSI_VERSION = 61662e8596dd9a64e3372f9a3ba6622d2628607c
EDK2_NON_OSI_SITE = $(call github,tianocore,edk2-non-osi,$(EDK2_NON_OSI_VERSION))
EDK2_NON_OSI_INSTALL_TARGET = NO
EDK2_NON_OSI_INSTALL_STAGING = YES

# Copy Marvell Armada files
EDK2_NON_OSI_LICENSE += BSD-2-Clause-Patent (Marvell Armada)
EDK2_NON_OSI_LICENSE_FILES += Silicon/Marvell/Armada7k8k/DeviceTree/Armada80x0McBin.inf
EDK2_NON_OSI_DIRS += Silicon/Marvell/Armada7k8k/DeviceTree

# There is nothing to build for edk2-non-osi. All we need to do is to copy
# the selected description files to staging, for other packages to build with.
define EDK2_NON_OSI_INSTALL_STAGING_CMDS
	$(foreach d,$(EDK2_NON_OSI_DIRS),\
		mkdir -p $(STAGING_DIR)/usr/share/edk2-non-osi/$(d) && \
		cp -rf $(@D)/$(d)/* $(STAGING_DIR)/usr/share/edk2-non-osi/$(d)/
	)
endef

$(eval $(generic-package))
