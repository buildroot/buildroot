################################################################################
#
# wmenu
#
################################################################################

WMENU_VERSION = 0.2.0
WMENU_SOURCE = $(WMENU_VERSION).tar.gz
WMENU_SITE = https://codeberg.org/adnano/wmenu/archive
WMENU_LICENSE = MIT
WMENU_LICENSE_FILES = LICENSE
WMENU_DEPENDENCIES = \
	cairo \
	pango \
	wayland \
	libxkbcommon \
	wayland \
	wayland-protocols

$(eval $(meson-package))
