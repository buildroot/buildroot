################################################################################
#
# ohsongcast
#
################################################################################

OHSONGCAST_VERSION = 3299eaedfea34993b79e6d30444792d4fb12a110
OHSONGCAST_SITE = $(call github,openhome,ohSongcast,$(OHSONGCAST_VERSION))
OHSONGCAST_LICENSE = BSD-2c
OHSONGCAST_LICENSE_FILES = License.txt BsdLicense.txt
OHSONGCAST_DEPENDENCIES = ohnet ohnetgenerated ohtopology
OHSONGCAST_INSTALL_STAGING = YES
OHSONGCAST_INSTALL_TARGET = NO

OHSONGCAST_MAKE_OPTS = \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	includes=-I$(STAGING_DIR)/usr/include/ohNet/ \
	ohnetdir=$(STAGING_DIR)/usr/lib/ohNet/ \
	ohnetgenerateddir=$(STAGING_DIR)/usr/lib/ohNetGenerated/ \
	ohtopologydir=$(STAGING_DIR)/usr/lib/ohTopology/ \
	nativeonly=yes

# only build the library
define OHSONGCAST_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(OHSONGCAST_MAKE_OPTS) \
		release=1 Build/Obj/Posix/Release/libohSongcast.a
endef

define OHSONGCAST_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/Debug.h $(STAGING_DIR)/usr/include/OpenHome/OhSongcast/Debug.h
	$(INSTALL) -D -m 0755 $(@D)/Product.h $(STAGING_DIR)/usr/include/OpenHome/Product.h
	$(INSTALL) -D -m 0755 $(@D)/OhmMsg.h $(STAGING_DIR)/usr/include/OpenHome/OhmMsg.h
	$(INSTALL) -D -m 0755 $(@D)/OhmSender.h $(STAGING_DIR)/usr/include/OpenHome/OhmSender.h
	$(INSTALL) -D -m 0755 $(@D)/OhmReceiver.h $(STAGING_DIR)/usr/include/OpenHome/OhmReceiver.h
	$(INSTALL) -D -m 0755 $(@D)/Ohm.h $(STAGING_DIR)/usr/include/OpenHome/Ohm.h
	$(INSTALL) -D -m 0755 $(@D)/OhmSocket.h $(STAGING_DIR)/usr/include/OpenHome/OhmSocket.h
	$(INSTALL) -D -m 0755 $(@D)/OhmSenderDriver.h $(STAGING_DIR)/usr/include/OpenHome/OhmSenderDriver.h
	$(INSTALL) -D -m 0755 $(@D)/Build/Obj/Posix/Release/libohSongcast.a \
		$(STAGING_DIR)/usr/lib/ohSongcast/libohSongcast.a
endef

#define OHSONGCAST_INSTALL_TARGET_CMDS
#	$(INSTALL) -D -m 0755 $(@D)/Build/Obj/Posix/Release/libohSongcast.so \
#		$(TARGET_DIR)/usr/lib/libohSongcast.so
#endef

$(eval $(generic-package))
