################################################################################
#
# libcap-ng
#
################################################################################

LIBCAP_NG_VERSION = 0.9.3
LIBCAP_NG_SITE = $(call github,stevegrubb,libcap-ng,v$(LIBCAP_NG_VERSION))
LIBCAP_NG_LICENSE = GPL-2.0+ (programs), LGPL-2.1+ (library)
LIBCAP_NG_LICENSE_FILES = COPYING COPYING.LIB
LIBCAP_NG_CPE_ID_VALID = YES
LIBCAP_NG_INSTALL_STAGING = YES

# github tarball does not include configure
LIBCAP_NG_AUTORECONF = YES
# needed for autoreconf
LIBCAP_NG_DEPENDENCIES = host-pkgconf
HOST_LIBCAP_NG_DEPENDENCIES = host-pkgconf

define LIBCAP_NG_CREATE_MISSING_FILES
	touch $(@D)/NEWS
endef
LIBCAP_NG_POST_EXTRACT_HOOKS += LIBCAP_NG_CREATE_MISSING_FILES
HOST_LIBCAP_NG_POST_EXTRACT_HOOKS += LIBCAP_NG_CREATE_MISSING_FILES

LIBCAP_NG_CONF_ENV = ac_cv_prog_swig_found=no
LIBCAP_NG_CONF_OPTS = --without-python3

# pthread support uses pthread_atfork, which is not available on nommu
ifneq ($(BR2_USE_MMU),y)
LIBCAP_NG_CONF_ENV += ac_cv_header_pthread_h=no
endif

HOST_LIBCAP_NG_CONF_ENV = ac_cv_prog_swig_found=no
HOST_LIBCAP_NG_CONF_OPTS = --without-python3

$(eval $(autotools-package))
$(eval $(host-autotools-package))
