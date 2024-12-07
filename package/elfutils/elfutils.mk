################################################################################
#
# elfutils
#
################################################################################

ELFUTILS_VERSION = 0.192
ELFUTILS_SOURCE = elfutils-$(ELFUTILS_VERSION).tar.bz2
ELFUTILS_SITE = https://sourceware.org/elfutils/ftp/$(ELFUTILS_VERSION)
ELFUTILS_INSTALL_STAGING = YES
ELFUTILS_LICENSE = GPL-2.0+ or LGPL-3.0+ (library)
ELFUTILS_LICENSE_FILES = COPYING COPYING-GPLV2 COPYING-LGPLV3
ELFUTILS_CPE_ID_VALID = YES
ELFUTILS_DEPENDENCIES = host-pkgconf zlib $(TARGET_NLS_DEPENDENCIES)
HOST_ELFUTILS_DEPENDENCIES = host-pkgconf host-zlib host-bzip2 host-xz host-zstd

# We patch configure.ac
ELFUTILS_AUTORECONF = YES
HOST_ELFUTILS_AUTORECONF = YES

# Pass a custom program prefix to avoid a naming conflict between
# elfutils binaries and binutils binaries.
ELFUTILS_CONF_OPTS += \
	--program-prefix="eu-"

HOST_ELFUTILS_CONF_OPTS = \
	--with-bzlib \
	--with-lzma \
	--with-zstd \
	--disable-demangler \
	--disable-progs

ELFUTILS_LDFLAGS = $(TARGET_LDFLAGS) \
	$(TARGET_NLS_LIBS)

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
ELFUTILS_LDFLAGS += -latomic
endif

ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),)
ELFUTILS_DEPENDENCIES += musl-fts argp-standalone
endif

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
ELFUTILS_CONF_OPTS += --disable-symbol-versioning
endif

ifeq ($(BR2_microblaze),y)
ELFUTILS_CONF_OPTS += --disable-symbol-versioning
endif

# disable for now, needs "distro" support
ELFUTILS_CONF_OPTS += --disable-libdebuginfod --disable-debuginfod
HOST_ELFUTILS_CONF_OPTS += --disable-libdebuginfod --disable-debuginfod

ELFUTILS_CONF_ENV += \
	LDFLAGS="$(ELFUTILS_LDFLAGS)"

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
ELFUTILS_CONF_OPTS += --enable-demangler
else
ELFUTILS_CONF_OPTS += --disable-demangler
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
ELFUTILS_DEPENDENCIES += bzip2
ELFUTILS_CONF_OPTS += --with-bzlib
else
ELFUTILS_CONF_OPTS += --without-bzlib
endif

ifeq ($(BR2_PACKAGE_XZ),y)
ELFUTILS_DEPENDENCIES += xz
ELFUTILS_CONF_OPTS += --with-lzma
else
ELFUTILS_CONF_OPTS += --without-lzma
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
ELFUTILS_DEPENDENCIES += zstd
ELFUTILS_CONF_OPTS += --with-zstd
else
ELFUTILS_CONF_OPTS += --without-zstd
endif

ifeq ($(BR2_PACKAGE_ELFUTILS_PROGS),y)
ELFUTILS_CONF_OPTS += --enable-progs
ELFUTILS_LICENSE += , GPL-3.0+ (programs)
ELFUTILS_LICENSE_FILES += COPYING
else
ELFUTILS_CONF_OPTS += --disable-progs
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
