################################################################################
#
# libliftoff
#
################################################################################

LIBLIFTOFF_VERSION = 0.5.0
LIBLIFTOFF_SITE = https://gitlab.freedesktop.org/emersion/libliftoff/-/releases/v$(LIBLIFTOFF_VERSION)/downloads
LIBLIFTOFF_LICENSE = MIT
LIBLIFTOFF_LICENSE_FILES = LICENSE
LIBLIFTOFF_INSTALL_STAGING = YES
LIBLIFTOFF_DEPENDENCIES = host-pkgconf libdrm
LIBLIFTOFF_CONF_OPTS = -Dwerror=false

$(eval $(meson-package))
