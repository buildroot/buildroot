################################################################################
#
# smcroute
#
################################################################################

SMCROUTE_VERSION = 2.5.2
SMCROUTE_SITE = https://github.com/troglobit/smcroute/releases/download/$(SMCROUTE_VERSION)
SMCROUTE_LICENSE = GPL-2.0+
SMCROUTE_LICENSE_FILES = COPYING
SMCROUTE_CPE_ID_VENDOR = troglobit

SMCROUTE_CONF_OPTS = --enable-mrdisc

ifeq ($(BR2_PACKAGE_LIBCAP),y)
SMCROUTE_DEPENDENCIES = libcap
SMCROUTE_CONF_OPTS += --with-libcap
else
SMCROUTE_CONF_OPTS += --without-libcap
endif

$(eval $(autotools-package))
