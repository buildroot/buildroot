################################################################################
#
# mbedtls
#
################################################################################

MBEDTLS_VERSION = 2.28.3
MBEDTLS_SITE = $(call github,ARMmbed,mbedtls,v$(MBEDTLS_VERSION))
MBEDTLS_CONF_OPTS = \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -std=c99" \
	-DENABLE_PROGRAMS=$(if $(BR2_PACKAGE_MBEDTLS_PROGRAMS),ON,OFF) \
	-DENABLE_TESTING=OFF \
	-DMBEDTLS_FATAL_WARNINGS=OFF
MBEDTLS_INSTALL_STAGING = YES
MBEDTLS_LICENSE = Apache-2.0
MBEDTLS_LICENSE_FILES = LICENSE
MBEDTLS_CPE_ID_VENDOR = arm
MBEDTLS_CPE_ID_PRODUCT = mbed_tls

# This is mandatory for hiawatha
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
define MBEDTLS_ENABLE_THREADING
	$(SED) "s://#define MBEDTLS_THREADING_C:#define MBEDTLS_THREADING_C:" \
		$(@D)/include/mbedtls/config.h
	$(SED) "s://#define MBEDTLS_THREADING_PTHREAD:#define MBEDTLS_THREADING_PTHREAD:" \
		$(@D)/include/mbedtls/config.h
endef
MBEDTLS_PRE_CONFIGURE_HOOKS += MBEDTLS_ENABLE_THREADING
ifeq ($(BR2_STATIC_LIBS),y)
MBEDTLS_CONF_OPTS += -DLINK_WITH_PTHREAD=ON
endif
endif

ifeq ($(BR2_STATIC_LIBS),y)
MBEDTLS_CONF_OPTS += \
	-DUSE_SHARED_MBEDTLS_LIBRARY=OFF -DUSE_STATIC_MBEDTLS_LIBRARY=ON
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
MBEDTLS_CONF_OPTS += \
	-DUSE_SHARED_MBEDTLS_LIBRARY=ON -DUSE_STATIC_MBEDTLS_LIBRARY=ON
else ifeq ($(BR2_SHARED_LIBS),y)
MBEDTLS_CONF_OPTS += \
	-DUSE_SHARED_MBEDTLS_LIBRARY=ON -DUSE_STATIC_MBEDTLS_LIBRARY=OFF
endif

ifeq ($(BR2_PACKAGE_MBEDTLS_COMPRESSION),y)
MBEDTLS_CONF_OPTS += -DENABLE_ZLIB_SUPPORT=ON
MBEDTLS_DEPENDENCIES += zlib
define MBEDTLS_ENABLE_ZLIB
	$(SED) "s://#define MBEDTLS_ZLIB_SUPPORT:#define MBEDTLS_ZLIB_SUPPORT:" \
		$(@D)/include/mbedtls/config.h
endef
MBEDTLS_PRE_CONFIGURE_HOOKS += MBEDTLS_ENABLE_ZLIB
else
MBEDTLS_CONF_OPTS += -DENABLE_ZLIB_SUPPORT=OFF
endif

define MBEDTLS_DISABLE_ASM
	$(SED) '/^#define MBEDTLS_AESNI_C/d' \
		$(@D)/include/mbedtls/config.h
	$(SED) '/^#define MBEDTLS_HAVE_ASM/d' \
		$(@D)/include/mbedtls/config.h
	$(SED) '/^#define MBEDTLS_PADLOCK_C/d' \
		$(@D)/include/mbedtls/config.h
endef

# ARM in thumb mode breaks debugging with asm optimizations
# Microblaze asm optimizations are broken in general
# MIPS R6 asm is not yet supported
ifeq ($(BR2_ENABLE_DEBUG)$(BR2_ARM_INSTRUCTIONS_THUMB)$(BR2_ARM_INSTRUCTIONS_THUMB2),yy)
MBEDTLS_POST_CONFIGURE_HOOKS += MBEDTLS_DISABLE_ASM
else ifeq ($(BR2_microblaze)$(BR2_MIPS_CPU_MIPS32R6)$(BR2_MIPS_CPU_MIPS64R6),y)
MBEDTLS_POST_CONFIGURE_HOOKS += MBEDTLS_DISABLE_ASM
endif

ifeq ($(BR2_PACKAGE_MBEDTLS_DTLS_SRTP),y)
define MBEDTLS_ENABLE_DTLS_SRTP
	$(SED) "s://#define MBEDTLS_SSL_DTLS_SRTP:#define MBEDTLS_SSL_DTLS_SRTP:" \
		$(@D)/include/mbedtls/config.h
endef
MBEDTLS_PRE_CONFIGURE_HOOKS += MBEDTLS_ENABLE_DTLS_SRTP
endif

$(eval $(cmake-package))
