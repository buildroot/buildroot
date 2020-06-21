#############################################################
#
# love2d
#
#############################################################
LOVE2D_VERSION = 11.3
LOVE2D_SITE = $(call github,love2d,love,$(LOVE2D_VERSION))
LOVE2D_LICENSE = zlib
LOVE2D_LICENSE_FILES = license.txt
LOVE2D_SUPPORTS_IN_SOURCE_BUILD = NO

LOVE2D_DEPENDENCIES = libgles luainterpreter sdl2 \
					  libmodplug libvorbis openal \
					  libtheora freetype

LOVE2D_CONF_OPTS += -DOPENGL_opengl_LIBRARY=$(STAGING_DIR)/usr/lib/libGLESv2.so \
					-DOPENGL_INCLUDE_DIR=$(STAGING_DIR)/include/GLES2 \
					-DOPENGL_glx_LIBRARY=$(STAGING_DIR)/usr/lib/libGLESv2.so \
					-DLOVE_JIT=$(if $(BR2_PACKAGE_LUAJIT),ON,OFF)

ifeq ($(BR2_PACKAGE_MPG123),y)
LOVE2D_DEPENDENCIES += mpg123
LOVE2D_CONF_OPTS += -DLOVE_MPG123=ON
else
LOVE2D_CONF_OPTS += -DLOVE_MPG123=OFF
endif

define LOVE2D_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/buildroot-build/*.so $(TARGET_DIR)/usr/lib/
	$(INSTALL) -D -m 0755 $(@D)/buildroot-build/love $(TARGET_DIR)/usr/bin/
endef

$(eval $(cmake-package))
