################################################################################
#
# libiconv
#
################################################################################

LIBICONV_VERSION = 1.18
LIBICONV_SITE = $(BR2_GNU_MIRROR)/libiconv
LIBICONV_INSTALL_STAGING = YES
LIBICONV_LICENSE = GPL-3.0+ (iconv program), LGPL-2.1+ (library)
LIBICONV_LICENSE_FILES = COPYING COPYING.LIB

# libiconv uses a patched version of libtool 2.5.4
# we use a package-specific patch instead
LIBICONV_LIBTOOL_PATCH = NO

ifeq ($(BR2_PACKAGE_LIBICONV_EXTRA_ENCODINGS),y)
LIBICONV_CONF_OPTS += --enable-extra-encodings
endif

# Don't build the preloadable library, as we don't need it (it's only
# for LD_PRELOAD to replace glibc's iconv, but we never build libiconv
# when glibc is used). And it causes problems for static only builds.
define LIBICONV_DISABLE_PRELOAD
	$(SED) '/preload/d' $(@D)/Makefile.in
endef
LIBICONV_PRE_CONFIGURE_HOOKS += LIBICONV_DISABLE_PRELOAD

$(eval $(autotools-package))

# Configurations where the toolchain supports locales and the libiconv
# package is enabled are incorrect, because the toolchain already
# provides libiconv functionality, and having both confuses packages.
ifeq ($(BR2_PACKAGE_LIBICONV)$(BR2_ENABLE_LOCALE),yy)
$(error Libiconv should never be enabled when the toolchain supports locales. Report this failure to Buildroot developers)
endif
