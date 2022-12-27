################################################################################
#
# dieharder
#
################################################################################

DIEHARDER_VERSION = 3.31.1.4
DIEHARDER_SITE = $(call github,eddelbuettel,dieharder,$(DIEHARDER_VERSION))
DIEHARDER_LICENSE = GPL-2.0 with beverage clause
DIEHARDER_LICENSE_FILES = COPYING
DIEHARDER_DEPENDENCIES = gsl
# configure retrieved from git is outdated
DIEHARDER_AUTORECONF = YES

# fix endianness detection
ifeq ($(BR2_ENDIAN),"BIG")
DIEHARDER_CONF_ENV = ac_cv_c_endian=big
else
DIEHARDER_CONF_ENV = ac_cv_c_endian=little
endif

# parallel build fail, disable it
DIEHARDER_MAKE = $(MAKE1)

$(eval $(autotools-package))
