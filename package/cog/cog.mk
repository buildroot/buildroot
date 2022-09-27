################################################################################
#
# cog
#
################################################################################

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_38),y)
COG_VERSION = 0.14.1
else
COG_VERSION = 0.6.0
endif

COG_SITE = https://wpewebkit.org/releases
COG_SOURCE = cog-$(COG_VERSION).tar.xz
COG_INSTALL_STAGING = YES
COG_DEPENDENCIES = dbus wpewebkit
COG_LICENSE = MIT
COG_LICENSE_FILES = COPYING
COG_CONF_OPTS = \
	-DCOG_BUILD_PROGRAMS=ON \
	-DINSTALL_MAN_PAGES=OFF \
	-DCOG_HOME_URI='$(call qstrip,$(BR2_PACKAGE_COG_PROGRAMS_HOME_URI))'

# Add the wpebackend-fdo dependency if any of the backends which
# need it have been selected (i.e. the expansion is non-empty.)
ifneq ($(BR2_PACKAGE_COG_PLATFORM_HEADLESS)$(BR2_PACKAGE_COG_PLATFORM_FDO)$(BR2_PACKAGE_COG_PLATFORM_DRM),)
COG_DEPENDENCIES += wpebackend-fdo
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT2_38),y)
COG_FDO_PLATFORM_CMAKE_OPTION = COG_PLATFORM_WL
COG_CONF_OPTS += \
	-DCOG_PLATFORM_GTK4=OFF \
	-DCOG_PLATFORM_X11=OFF \
	-DUSE_SOUP2=OFF
else
COG_FDO_PLATFORM_CMAKE_OPTION = COG_PLATFORM_FDO
COG_CONF_OPTS += \
	-DUSE_SOUP2=ON
endif # BR2_PACKAGE_WPEWEBKIT2_38

ifeq ($(BR2_PACKAGE_WESTON),y)
COG_CONF_OPTS += -DCOG_WESTON_DIRECT_DISPLAY=ON
COG_DEPENDENCIES += weston
else
COG_CONF_OPTS += -DCOG_WESTON_DIRECT_DISPLAY=OFF
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_HEADLESS),y)
COG_CONF_OPTS += -DCOG_PLATFORM_HEADLESS=ON
else
COG_CONF_OPTS += -DCOG_PLATFORM_HEADLESS=OFF
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_FDO),y)
COG_CONF_OPTS += -D$(COG_FDO_PLATFORM_CMAKE_OPTION)=ON
COG_DEPENDENCIES += libxkbcommon wayland-protocols wayland
else
COG_CONF_OPTS += -D$(COG_FDO_PLATFORM_CMAKE_OPTION)=OFF
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_DRM),y)
COG_CONF_OPTS += -DCOG_PLATFORM_DRM=ON
COG_DEPENDENCIES += libdrm libinput libgbm libegl udev
else
COG_CONF_OPTS += -DCOG_PLATFORM_DRM=OFF
endif

ifeq ($(BR2_PACKAGE_COG_USE_SYSTEM_DBUS),y)
define COG_INSTALL_DBUS_POLICY
	$(RM) $(TARGET_DIR)/etc/dbus-1/systemd.d/com.igalia.Cog.conf
	$(INSTALL) -D -m 0644 $(@D)/com.igalia.Cog.conf $(TARGET_DIR)/usr/share/dbus-1/system.d/
endef
COG_POST_INSTALL_TARGET_HOOKS += COG_INSTALL_DBUS_POLICY
COG_CONF_OPTS += -DCOG_DBUS_SYSTEM_BUS=ON
else
COG_CONF_OPTS += -DCOG_DBUS_SYSTEM_BUS=OFF
endif # BR2_PACKAGE_COG_USE_SYSTEM_DBUS

define COG_INSTALL_SETTINGS
	$(INSTALL) -D -m 0644 package/cog/websettings.txt $(TARGET_DIR)/root
endef
COG_POST_INSTALL_TARGET_HOOKS += COG_INSTALL_SETTINGS

$(eval $(cmake-package))
