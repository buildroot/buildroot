################################################################################
#
# ohnetgenerated
#
################################################################################

OHNETGENERATED_VERSION = ohNetGenerated_1.1.112
OHNETGENERATED_SITE = $(call github,openhome,ohNetGenerated,$(OHNETGENERATED_VERSION))
OHNETGENERATED_LICENSE = MIT
OHNETGENERATED_LICENSE_FILES = License.txt
OHNETGENERATED_DEPENDENCIES = ohnet

OHNETGENERATED_INSTALL_STAGING = YES

# Note, the trailing slashes are needed
OHNETGENERATED_MAKE_OPTS = \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	ohNetLibDir="$(STAGING_DIR)/usr/lib/ohNet/" \
	inc_build="$(STAGING_DIR)/usr/include/ohNet/" \
	header_install="$(STAGING_DIR)/usr/include/ohNet" \
	native_only=yes \
	nocpp11=yes

define OHNETGENERATED_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) $(OHNETGENERATED_MAKE_OPTS)
endef

define OHNETGENERATED_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/Build/Obj/Posix/Release/libohNetGeneratedProxies.a \
		$(STAGING_DIR)/usr/lib/ohNetGenerated/libohNetGeneratedProxies.a
	$(INSTALL) -D -m 0755 $(@D)/Build/Obj/Posix/Release/libohNetGeneratedDevices.a \
		$(STAGING_DIR)/usr/lib/ohNetGenerated/libohNetGeneratedDevices.a
endef

$(eval $(generic-package))
