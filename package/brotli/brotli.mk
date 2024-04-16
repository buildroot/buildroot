################################################################################
#
# brotli
#
################################################################################

BROTLI_VERSION = 1.1.0
BROTLI_SOURCE = v$(BROTLI_VERSION).tar.gz
BROTLI_SITE = https://github.com/google/brotli/archive
BROTLI_LICENSE = MIT
BROTLI_LICENSE_FILES = LICENSE
BROTLI_CPE_ID_VENDOR = google
BROTLI_INSTALL_STAGING = YES
BROTLI_CONF_OPTS = \
	-DBROTLI_DISABLE_TESTS=ON \
	-DBROTLI_BUNDLED_MODE=OFF

BROTLI_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_68485),y)
BROTLI_CFLAGS += -O0
endif

# Workaround "Error: value -1234 out of range" assembler issues
# when building with optimizations.
ifeq ($(BR2_m68k),y)
BROTLI_CFLAGS += -Os
endif

BROTLI_CONF_OPTS += -DCMAKE_C_FLAGS="$(BROTLI_CFLAGS)"

$(eval $(cmake-package))
