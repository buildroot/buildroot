################################################################################
#
# gl4es
#
################################################################################

GL4ES_VERSION=b0f01af
GL4ES_SITE=$(call github,ptitSeb,gl4es,$(GL4ES_VERSION))
GL4ES_LICENSE = MIT
GL4ES_LICENSE_FILES = LICENSE

GL4ES_INSTALL_STAGING = YES

GL4ES_DEPENDENCIES = mesa3d
GL4ES_PROVIDES += libgl

ifeq ($(BR2_PACKAGE_XORG7),)
GL4ES_CONF_OPTS += -DNOX11=ON
endif

define GL4ES_ADD_STAGING_LIB_SYMLINK
	ln -sf gl4es/libGL.so.1 $(STAGING_DIR)/usr/lib/libGL.so.1
endef
GL4ES_POST_INSTALL_STAGING_HOOKS += GL4ES_ADD_STAGING_LIB_SYMLINK

define GL4ES_ADD_TARGET_LIB_SYMLINK
	ln -sf gl4es/libGL.so.1 $(TARGET_DIR)/usr/lib/libGL.so.1
endef
GL4ES_POST_INSTALL_TARGET_HOOKS += GL4ES_ADD_TARGET_LIB_SYMLINK

$(eval $(cmake-package))
