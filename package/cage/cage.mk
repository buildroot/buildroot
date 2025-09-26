################################################################################
#
# cage
#
################################################################################

CAGE_VERSION = v0.2.0-15-g2e593fe5a8a2186a558ceb414674775e4ba5d2b1
CAGE_SITE = https://github.com/cage-kiosk/cage.git
CAGE_SITE_METHOD = git
CAGE_LICENSE = MIT
CAGE_LICENSE_FILES = LICENSE
CAGE_DEPENDENCIES = host-pkgconf wlroots
CAGE_CONF_OPTS = -Dman-pages=disabled

$(eval $(meson-package))
