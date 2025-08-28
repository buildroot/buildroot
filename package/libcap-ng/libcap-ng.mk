################################################################################
#
# libcap-ng
#
################################################################################

LIBCAP_NG_VERSION = 0.8.5
LIBCAP_NG_SITE = https://people.redhat.com/sgrubb/libcap-ng
LIBCAP_NG_LICENSE = GPL-2.0+ (programs), LGPL-2.1+ (library)
LIBCAP_NG_LICENSE_FILES = COPYING COPYING.LIB
LIBCAP_NG_CPE_ID_VALID = YES
LIBCAP_NG_INSTALL_STAGING = YES

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
