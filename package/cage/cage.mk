################################################################################
#
# cage
#
################################################################################

CAGE_VERSION = 0.2.0
CAGE_SITE = https://github.com/cage-kiosk/cage/releases/download/v$(CAGE_VERSION)
CAGE_LICENSE = MIT
CAGE_LICENSE_FILES = LICENSE
CAGE_DEPENDENCIES = host-pkgconf wlroots
CAGE_CONF_OPTS = -Dman-pages=disabled

$(eval $(meson-package))
