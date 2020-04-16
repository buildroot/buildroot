################################################################################
#
# cog
#
################################################################################

COG_VERSION = 0.6.0
COG_SITE = https://wpewebkit.org/releases
COG_SOURCE = cog-$(COG_VERSION).tar.xz
COG_INSTALL_STAGING = YES
COG_DEPENDENCIES = dbus wpewebkit
COG_LICENSE = MIT
COG_LICENSE_FILES = COPYING
COG_CONF_OPTS = \
	-DCOG_BUILD_PROGRAMS=ON \
	-DCOG_WESTON_DIRECT_DISPLAY=OFF \
	-DINSTALL_MAN_PAGES=OFF \
	-DCOG_HOME_URI='$(call qstrip,$(BR2_PACKAGE_COG_PROGRAMS_HOME_URI))'

ifeq ($(BR2_PACKAGE_COG_PLATFORM_FDO),y)
COG_CONF_OPTS += -DCOG_PLATFORM_FDO=ON
COG_DEPENDENCIES += libxkbcommon wayland-protocols wpebackend-fdo wayland
else
COG_CONF_OPTS += -DCOG_PLATFORM_FDO=OFF
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_DRM),y)
COG_CONF_OPTS += -DCOG_PLATFORM_DRM=ON
COG_DEPENDENCIES += libdrm libinput
else
COG_CONF_OPTS += -DCOG_PLATFORM_DRM=OFF
endif

define COG_INSTALL_SETTINGS
	$(INSTALL) -D -m 0644 package/cog/websettings.txt $(TARGET_DIR)/root
endef

COG_POST_INSTALL_TARGET_HOOKS += COG_INSTALL_SETTINGS

$(eval $(cmake-package))
