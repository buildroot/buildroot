################################################################################
#
# playready
#
################################################################################

PLAYREADY_VERSION = 1a3eb64c77b94b1c84e34a0453a56d4ec67ccb11
PLAYREADY_SITE = git@github.com:Metrological/playready.git
PLAYREADY_SITE_METHOD = git
PLAYREADY_LICENSE = PROPRIETARY
PLAYREADY_DEPENDENCIES = 
PLAYREADY_INSTALL_STAGING = YES
PLAYREADY_INSTALL_TARGET = YES
PLAYREADY_SUBDIR = src

PLAYREADY_CONF_OPTS = \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_C_FLAGS="-std=c99 -D_GNU_SOURCE"

define PLAYREADY_INSTALL_STAGING_PC
	$(INSTALL) -D package/playready/playready.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/playready.pc
endef

define PLAYREADY_INSTALL_TARGET_PC
	$(INSTALL) -D package/playready/playready.pc \
		$(TARGET_DIR)/usr/lib/pkgconfig/playready.pc
endef

PLAYREADY_POST_INSTALL_STAGING_HOOKS += PLAYREADY_INSTALL_STAGING_PC
PLAYREADY_POST_INSTALL_TARGET_HOOKS += PLAYREADY_INSTALL_TARGET_PC

$(eval $(cmake-package))
