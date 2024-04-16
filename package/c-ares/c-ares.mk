################################################################################
#
# c-ares
#
################################################################################

C_ARES_VERSION = 1.27.0
C_ARES_SITE = http://c-ares.haxx.se/download
C_ARES_INSTALL_STAGING = YES
C_ARES_CONF_OPTS = --with-random=/dev/urandom
C_ARES_LICENSE = MIT
C_ARES_LICENSE_FILES = LICENSE.md
C_ARES_CPE_ID_VENDOR = c-ares

$(eval $(autotools-package))
$(eval $(host-autotools-package))
