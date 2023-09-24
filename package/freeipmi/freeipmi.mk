################################################################################
#
# freeipmi
#
################################################################################

FREEIPMI_VERSION = 1.6.11
FREEIPMI_SITE = https://ftp.gnu.org/gnu/freeipmi
FREEIPMI_LICENSE = GPL-3.0+, BSD-like (sunbmc)
FREEIPMI_LICENSE_FILES = \
	COPYING COPYING.bmc-watchdog COPYING.ipmiconsole COPYING.ipmi-dcmi \
	COPYING.ipmidetect COPYING.ipmi-fru COPYING.ipmimonitoring \
	COPYING.ipmiping COPYING.ipmipower COPYING.ipmiseld COPYING.pstdout \
	COPYING.sunbmc COPYING.ZRESEARCH
FREEIPMI_DEPENDENCIES = host-pkgconf
FREEIPMI_INSTALL_STAGING = YES
# Disable checking for /dev/urandom and /dev/random through AC_CHECK_FILE
FREEIPMI_CONF_OPTS = --without-random-device

# Work around for uClibc or musl toolchains which lack argp_*()
# functions.
ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
FREEIPMI_DEPENDENCIES += argp-standalone $(TARGET_NLS_DEPENDENCIES)
FREEIPMI_CONF_ENV = LIBS=$(TARGET_NLS_LIBS)
endif

ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
FREEIPMI_CONF_OPTS += --with-encryption
FREEIPMI_DEPENDENCIES += libgcrypt
else
FREEIPMI_CONF_OPTS += --without-encryption
endif

$(eval $(autotools-package))
