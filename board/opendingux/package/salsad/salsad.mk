#############################################################
#
# salsad
#
#############################################################
SALSAD_VERSION = 740b7cc
SALSAD_SITE = $(call github,JohnnyonFlame,salsad,$(SALSAD_VERSION))
SALSAD_DEPENDENCIES = alsa-lib
SALSAD_LICENSE = GPLv3
SALSAD_LICENSE_FILES = LICENSE.md

define SALSAD_INSTALL_INIT_FILE
	$(INSTALL) -D -m 0755 board/opendingux/package/salsad/S80salsad.sh \
		$(TARGET_DIR)/etc/init.d/S80salsad.sh
endef
SALSAD_POST_INSTALL_TARGET_HOOKS += SALSAD_INSTALL_INIT_FILE

$(eval $(cmake-package))
