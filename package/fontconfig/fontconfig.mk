################################################################################
#
# fontconfig
#
################################################################################

FONTCONFIG_VERSION = 2.17.1
FONTCONFIG_SITE = https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/$(FONTCONFIG_VERSION)
FONTCONFIG_SOURCE = fontconfig-$(FONTCONFIG_VERSION).tar.xz
FONTCONFIG_INSTALL_STAGING = YES
FONTCONFIG_DEPENDENCIES = freetype expat host-pkgconf host-gperf \
	$(TARGET_NLS_DEPENDENCIES)
HOST_FONTCONFIG_DEPENDENCIES = host-freetype host-expat host-pkgconf \
	host-gperf host-gettext
FONTCONFIG_LICENSE = fontconfig license
FONTCONFIG_LICENSE_FILES = COPYING
FONTCONFIG_CPE_ID_VALID = YES

FONTCONFIG_CONF_OPTS = \
	-Dcache-dir=/var/cache/fontconfig \
	-Dtests=disabled \
	-Ddoc=disabled

FONTCONFIG_CFLAGS = $(TARGET_CFLAGS)

# See: https://gitlab.freedesktop.org/fontconfig/fontconfig/-/issues/436
ifeq ($(BR2_DEBUG_3),y)
FONTCONFIG_CFLAGS += -g2
endif

$(eval $(meson-package))
$(eval $(host-meson-package))
