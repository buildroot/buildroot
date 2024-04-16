################################################################################
#
# libunibreak
#
################################################################################

LIBUNIBREAK_VERSION = 5.1
LIBUNIBREAK_SITE = https://github.com/adah1972/libunibreak/releases/download/libunibreak_$(subst .,_,$(LIBUNIBREAK_VERSION))
LIBUNIBREAK_INSTALL_STAGING = YES
LIBUNIBREAK_LICENSE = Zlib
LIBUNIBREAK_LICENSE_FILES = LICENCE

$(eval $(autotools-package))
