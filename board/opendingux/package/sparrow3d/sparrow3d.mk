#############################################################
#
# sparrow3d
#
#############################################################
SPARROW3D_VERSION = 2033349
SPARROW3D_SITE = $(call github,theZiz,sparrow3d,$(SPARROW3D_VERSION))
SPARROW3D_LICENCE = LGPL
SPARROW3D_DEPENDENCIES = sdl sdl_net sdl_image sdl_ttf sdl_mixer

# TODO: install to staging area?
#SPARROW3D_INSTALL_STAGING = YES

SPARROW3D_MAKE_ENV = $(TARGET_MAKE_ENV) CC=$(TARGET_CC) \
					 FLAGS="-DMOBILE_DEVICE -DGCW -DFAST_MULTIPLICATION -DFAST_DIVISION -ffast-math" \
					 SDL="$(shell $(STAGING_DIR)/bin/sdl-config --cflags)"

define SPARROW3D_BUILD_CMDS
	$(MAKE) $(SPARROW3D_MAKE_ENV) -C $(@D)
endef

define SPARROW3D_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libsparrow{3d,Net,Sound}.so $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))
