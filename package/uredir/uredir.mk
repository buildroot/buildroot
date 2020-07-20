################################################################################
#
# uredir
#
################################################################################

UREDIR_VERSION = 3.3
UREDIR_SOURCE = uredir-$(UREDIR_VERSION).tar.gz
UREDIR_SITE = https://github.com/troglobit/uredir/releases/download/v$(UREDIR_VERSION)
UREDIR_LICENSE = ISC
UREDIR_LICENSE_FILES = LICENSE
UREDIR_DEPENDENCIES = host-pkgconf libuev

$(eval $(autotools-package))
