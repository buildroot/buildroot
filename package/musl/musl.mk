################################################################################
#
# musl
#
################################################################################

MUSL_VERSION = 1.2.5
MUSL_SITE = http://musl.libc.org/releases
MUSL_LICENSE = MIT
MUSL_LICENSE_FILES = COPYRIGHT
MUSL_CPE_ID_VENDOR = musl-libc

# Before musl is configured, we must have the first stage
# cross-compiler and the kernel headers
MUSL_DEPENDENCIES = host-gcc-initial linux-headers

# musl does not provide an implementation for sys/queue.h or sys/cdefs.h.
# So, add the musl-compat-headers package that will install those files,
# into the staging directory:
#   sys/queue.h:  header from NetBSD
#   sys/cdefs.h:  minimalist header bundled in Buildroot
MUSL_DEPENDENCIES += musl-compat-headers

# musl is part of the toolchain so disable the toolchain dependency
MUSL_ADD_TOOLCHAIN_DEPENDENCY = NO

MUSL_INSTALL_STAGING = YES

# 0004-iconv-fix-erroneous-input-validation-in-EUC-KR-decod.patch
# 0005-iconv-harden-UTF-8-output-code-path-against-input-de.patch
MUSL_IGNORE_CVES += CVE-2025-26519

# musl does not build with LTO, so explicitly disable it
# when using a compiler that may have support for LTO
ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_4_7),y)
MUSL_EXTRA_CFLAGS += -fno-lto
endif

# Thumb build is broken, build in ARM mode, since all architectures
# that support Thumb1 also support ARM.
ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
MUSL_EXTRA_CFLAGS += -marm
endif

define MUSL_CONFIGURE_CMDS
	(cd $(@D); \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(filter-out -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64,$(TARGET_CFLAGS)) $(MUSL_EXTRA_CFLAGS)" \
		CPPFLAGS="$(filter-out -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64,$(TARGET_CPPFLAGS))" \
		./configure \
			--target=$(GNU_TARGET_NAME) \
			--host=$(GNU_TARGET_NAME) \
			--prefix=/usr \
			--libdir=/lib \
			--disable-gcc-wrapper \
			--enable-static \
			$(if $(BR2_STATIC_LIBS),--disable-shared,--enable-shared))
endef

define MUSL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define MUSL_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		DESTDIR=$(STAGING_DIR) install-libs install-tools install-headers
	ln -sf libc.so $(STAGING_DIR)/lib/ld-musl*
endef

define MUSL_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		DESTDIR=$(TARGET_DIR) install-libs
	$(RM) $(addprefix $(TARGET_DIR)/lib/,crt1.o crtn.o crti.o rcrt1.o Scrt1.o)
	ln -sf libc.so $(TARGET_DIR)/lib/ld-musl*
endef

$(eval $(generic-package))
