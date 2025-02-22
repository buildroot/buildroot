################################################################################
#
# rnnoise
#
################################################################################

RNNOISE_VERSION = 0.2
RNNOISE_SITE = https://github.com/xiph/rnnoise/releases/download/v$(RNNOISE_VERSION)
RNNOISE_LICENSE = BSD-3-Clause
RNNOISE_LICENSE_FILES = COPYING
RNNOISE_INSTALL_STAGING = YES

RNNOISE_CONF_OPTS = --disable-examples

# rnnoise refuses to build with -Ofast unless FLOAT_APPROX is defined
ifeq ($(BR2_OPTIMIZE_FAST),y)
RNNOISE_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -DFLOAT_APPROX"
endif

$(eval $(autotools-package))
