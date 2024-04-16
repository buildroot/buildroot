################################################################################
#
# bayer2rgb-neon
#
################################################################################

BAYER2RGB_NEON_VERSION = bc950b3398ba034fe5cc39f625796a6111cdb87f
BAYER2RGB_NEON_SITE = https://gitlab-ext.sigma-chemnitz.de/ensc/bayer2rgb.git
BAYER2RGB_NEON_SITE_METHOD = git
BAYER2RGB_NEON_LICENSE = GPL-3.0
BAYER2RGB_NEON_LICENSE_FILES = COPYING
BAYER2RGB_NEON_INSTALL_STAGING = YES
BAYER2RGB_NEON_DEPENDENCIES = host-pkgconf host-gengetopt
BAYER2RGB_NEON_AUTORECONF = YES

BAYER2RGB_NEON_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_arm),y)
BAYER2RGB_NEON_CFLAGS += -mfpu=neon
endif

# __builtin_prefetch() third argument must be a constant, but
# bayer2rgb-neon uses a variable, derived from a constant, so some
# optimization is needed to allow the compiler to turn it into a
# constant, otherwise the build fails
ifeq ($(BR2_OPTIMIZE_0),y)
BAYER2RGB_NEON_CFLAGS += -O1
endif

BAYER2RGB_NEON_CONF_ENV = CFLAGS="$(BAYER2RGB_NEON_CFLAGS)"

$(eval $(autotools-package))
