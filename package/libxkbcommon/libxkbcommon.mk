################################################################################
#
# libxkbcommon
#
################################################################################

LIBXKBCOMMON_VERSION = 1.9.2
LIBXKBCOMMON_SITE = $(call github,xkbcommon,libxkbcommon,xkbcommon-$(LIBXKBCOMMON_VERSION))
LIBXKBCOMMON_LICENSE = MIT/X11
LIBXKBCOMMON_LICENSE_FILES = LICENSE
LIBXKBCOMMON_CPE_ID_VENDOR = xkbcommon
LIBXKBCOMMON_INSTALL_STAGING = YES
LIBXKBCOMMON_DEPENDENCIES = host-bison host-flex
LIBXKBCOMMON_CONF_OPTS = \
	-Denable-docs=false \
	-Denable-xkbregistry=false

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBXKBCOMMON_CONF_OPTS += -Denable-x11=true
LIBXKBCOMMON_DEPENDENCIES += libxcb
else
LIBXKBCOMMON_CONF_OPTS += -Denable-x11=false
endif

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON_TOOLS),y)
LIBXKBCOMMON_CONF_OPTS += -Denable-tools=true
else
LIBXKBCOMMON_CONF_OPTS += -Denable-tools=false
endif

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON_TOOLS)$(BR2_PACKAGE_WAYLAND),yy)
LIBXKBCOMMON_CONF_OPTS += -Denable-wayland=true
LIBXKBCOMMON_DEPENDENCIES += wayland wayland-protocols
else
LIBXKBCOMMON_CONF_OPTS += -Denable-wayland=false
endif

$(eval $(meson-package))
