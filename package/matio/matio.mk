################################################################################
#
# matio
#
################################################################################

MATIO_VERSION = 1.5.26
MATIO_SOURCE = matio-$(MATIO_VERSION).tar.xz
MATIO_SITE = \
	https://downloads.sourceforge.net/project/matio/matio/$(MATIO_VERSION)
MATIO_LICENSE = BSD-2-Clause
MATIO_LICENSE_FILES = COPYING
MATIO_CPE_ID_VALID = YES
MATIO_DEPENDENCIES = zlib
MATIO_INSTALL_STAGING = YES

# va_copy()
MATIO_CONF_ENV = ac_cv_va_copy=yes

MATIO_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_99410),y)
MATIO_CFLAGS += -O0
endif

MATIO_CONF_ENV += CFLAGS="$(MATIO_CFLAGS)"

# mat73 require hdf5 (not available), extented-sparse take 2KB
MATIO_CONF_OPTS = --disable-mat73 --enable-extended-sparse

$(eval $(autotools-package))
