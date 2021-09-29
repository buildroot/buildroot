################################################################################
#
# edk2-platforms
#
################################################################################

# Keep in sync with latest commit as of the release date for boot/edk2
EDK2_PLATFORMS_VERSION = db922e1253cb6f1fc456805bc42fb7d401eed5c2
EDK2_PLATFORMS_SITE = $(call github,tianocore,edk2-platforms,$(EDK2_PLATFORMS_VERSION))
EDK2_PLATFORMS_LICENSE = BSD-2-Clause
EDK2_PLATFORMS_LICENSE_FILE = License.txt
EDK2_PLATFORMS_INSTALL_TARGET = NO
EDK2_PLATFORMS_INSTALL_STAGING = YES

# There is nothing to build for edk2-platforms. All we need to do is to copy
# all description files to staging, for other packages to build with.
define EDK2_PLATFORMS_INSTALL_STAGING_CMDS
	rm -rf $(STAGING_DIR)/usr/share/edk2-platforms
	cp -rf $(@D) $(STAGING_DIR)/usr/share/edk2-platforms
endef

$(eval $(generic-package))
