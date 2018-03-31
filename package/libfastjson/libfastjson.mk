################################################################################
#
# libfastjson
#
################################################################################

LIBFASTJSON_VERSION = v0.99.4
LIBFASTJSON_SITE = $(call github,rsyslog,libfastjson,$(LIBFASTJSON_VERSION))
LIBFASTJSON_INSTALL_STAGING = YES
LIBFASTJSON_CONF_ENV = ac_cv_prog_cc_c99='-std=gnu99'
# From git
LIBFASTJSON_AUTORECONF = YES
LIBFASTJSON_LICENSE = MIT
LIBFASTJSON_LICENSE_FILES = COPYING
LIBFASTJSON_CPE_ID_VENDOR = adiscon

$(eval $(autotools-package))
