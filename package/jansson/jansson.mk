################################################################################
#
# jansson
#
################################################################################

JANSSON_VERSION = 2.14
JANSSON_SOURCE = jansson-$(JANSSON_VERSION).tar.bz2
JANSSON_SITE = \
	https://github.com/akheron/jansson/releases/download/v$(JANSSON_VERSION)
JANSSON_LICENSE = MIT
JANSSON_LICENSE_FILES = LICENSE
JANSSON_CPE_ID_VALID = YES
JANSSON_INSTALL_STAGING = YES
JANSSON_CONF_ENV = LIBS="-lm"

$(eval $(autotools-package))
