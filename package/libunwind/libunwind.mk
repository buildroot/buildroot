################################################################################
#
# libunwind
#
################################################################################

LIBUNWIND_VERSION = 1.6.2
LIBUNWIND_SITE = http://download.savannah.gnu.org/releases/libunwind
LIBUNWIND_INSTALL_STAGING = YES
LIBUNWIND_LICENSE_FILES = COPYING
LIBUNWIND_LICENSE = MIT
LIBUNWIND_CPE_ID_VALID = YES

LIBUNWIND_CONF_OPTS = \
	--disable-tests \
	$(if $(BR2_INSTALL_LIBSTDCPP),--enable-cxx-exceptions,--disable-cxx-exceptions)

ifeq ($(BR2_PACKAGE_LIBUCONTEXT),y)
LIBUNWIND_DEPENDENCIES += libucontext
LIBUNWIND_CONF_OPTS += LIBS=-lucontext
endif

$(eval $(autotools-package))
