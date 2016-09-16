################################################################################
#
# libfastjson
#
################################################################################

LIBFASTJSON_VERSION = 0.99.2
LIBFASTJSON_SITE = $(call github,rsyslog,libfastjson,$(LIBFASTJSON_VERSION))
LIBFASTJSON_SOURCE = v$(LIBFASTJSON_VERSION).tar.gz
LIBFASTJSON_INSTALL_STAGING = YES
# From git
LIBFASTJSON_AUTORECONF = YES
LIBFASTJSON_LICENSE = MIT
LIBFASTJSON_LICENSE_FILES = COPYING

$(eval $(autotools-package))
