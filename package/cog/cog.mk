################################################################################
#
# cog
#
################################################################################

COG_VERSION = 0.16.1
COG_SITE = https://wpewebkit.org/releases
COG_SOURCE = cog-$(COG_VERSION).tar.xz
COG_INSTALL_STAGING = YES
COG_DEPENDENCIES = dbus wpewebkit wpebackend-fdo wayland
COG_LICENSE = MIT
COG_LICENSE_FILES = COPYING
COG_CONF_OPTS = \
	-Ddocumentation=false \
	-Dmanpages=false \
	-Dprograms=true \
	-Dsoup2=enabled \
	-Dcog_home_uri='$(call qstrip,$(BR2_PACKAGE_COG_PROGRAMS_HOME_URI))' \
	-Dplatforms='$(subst $(space),$(comma),$(strip $(COG_PLATFORMS_LIST)))'

COG_PLATFORMS_LIST = headless

ifeq ($(BR2_PACKAGE_WESTON),y)
COG_CONF_OPTS += -Dwayland_weston_direct_display=true
COG_DEPENDENCIES += weston
else
COG_CONF_OPTS += -Dwayland_weston_direct_display=false
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_FDO),y)
COG_PLATFORMS_LIST += wayland
COG_DEPENDENCIES += libxkbcommon wayland-protocols
endif

ifeq ($(BR2_PACKAGE_COG_PLATFORM_DRM),y)
COG_PLATFORMS_LIST += drm
COG_DEPENDENCIES += libdrm libinput libgbm libegl udev
endif

ifeq ($(BR2_PACKAGE_COG_USE_SYSTEM_DBUS),y)
COG_CONF_OPTS += -Dcog_dbus_control=system
else
COG_CONF_OPTS += -Dcog_dbus_control=user
endif

ifeq ($(BR2_PACKAGE_LIBMANETTE),y)
COG_DEPENDENCIES += libmanette
endif

$(eval $(meson-package))
