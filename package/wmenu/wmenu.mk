################################################################################
#
# wmenu
#
################################################################################

WMENU_VERSION = 0.2.0
WMENU_SITE = https://codeberg.org/adnano/wmenu.git
WMENU_SITE_METHOD = git
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
