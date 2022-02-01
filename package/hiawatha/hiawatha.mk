################################################################################
#
# hiawatha
#
################################################################################

HIAWATHA_VERSION = 11.1
HIAWATHA_SITE = https://www.hiawatha-webserver.org/files
HIAWATHA_DEPENDENCIES = zlib
HIAWATHA_LICENSE = GPL-2.0
HIAWATHA_LICENSE_FILES = LICENSE
HIAWATHA_CPE_ID_VENDOR = hiawatha-webserver

# Disable system mbedtls as hiawatha needs mbedtls 3.x
HIAWATHA_CONF_OPTS = \
	-DINSTALL_MBEDTLS_HEADERS=OFF \
	-DUSE_SYSTEM_MBEDTLS=OFF \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -std=c99" \
	-DENABLE_TOOLKIT=OFF \
	-DCONFIG_DIR=/etc/hiawatha \
	-DLOG_DIR=/var/log \
	-DPID_DIR=/var/run \
	-DWEBROOT_DIR=/var/www/hiawatha \
	-DWORK_DIR=/var/lib/hiawatha

define HIAWATHA_MBEDTLS_DISABLE_ASM
	$(SED) '/^#define MBEDTLS_AESNI_C/d' \
		$(@D)/mbedtls/include/mbedtls/mbedtls_config.h
	$(SED) '/^#define MBEDTLS_HAVE_ASM/d' \
		$(@D)/mbedtls/include/mbedtls/mbedtls_config.h
	$(SED) '/^#define MBEDTLS_PADLOCK_C/d' \
		$(@D)/mbedtls/include/mbedtls/mbedtls_config.h
endef

# ARM in thumb mode breaks debugging with asm optimizations
# Microblaze asm optimizations are broken in general
# MIPS R6 asm is not yet supported
ifeq ($(BR2_ENABLE_DEBUG)$(BR2_ARM_INSTRUCTIONS_THUMB)$(BR2_ARM_INSTRUCTIONS_THUMB2),yy)
HIAWATHA_POST_CONFIGURE_HOOKS += HIAWATHA_MBEDTLS_DISABLE_ASM
else ifeq ($(BR2_microblaze)$(BR2_MIPS_CPU_MIPS32R6)$(BR2_MIPS_CPU_MIPS64R6),y)
HIAWATHA_POST_CONFIGURE_HOOKS += HIAWATHA_MBEDTLS_DISABLE_ASM
endif

ifeq ($(BR2_PACKAGE_HIAWATHA_SSL),y)
HIAWATHA_CONF_OPTS += -DENABLE_TLS=ON
else
HIAWATHA_CONF_OPTS += -DENABLE_TLS=OFF
endif

ifeq ($(BR2_PACKAGE_LIBXSLT),y)
HIAWATHA_CONF_OPTS += -DENABLE_XSLT=ON
HIAWATHA_DEPENDENCIES += libxslt
else
HIAWATHA_CONF_OPTS += -DENABLE_XSLT=OFF
endif

$(eval $(cmake-package))
