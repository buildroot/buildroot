################################################################################
#
# poke
#
################################################################################

POKE_VERSION = 1.2
POKE_SITE = $(BR2_GNU_MIRROR)/poke
# gnulib license is a mix/mess of public-domain and various GPL and LGPL versions.
POKE_LICENSE = GPL-3.0+, GPL-3.0+ (jitter), gnulib license (gnulib)
POKE_LICENSE_FILES = COPYING jitter/COPYING

# 0001-build-do-not-check-for-Tcl-Tk-if-disable-gui-is-spec.patch
# 0003-configure.ac-HELP2MAN-replace-by-false-when-cross-co.patch
POKE_AUTORECONF = YES

POKE_DEPENDENCIES = host-flex host-bison host-pkgconf bdwgc readline

POKE_CONF_OPTS = \
	--disable-gui \
	--disable-libnbd \
	--with-libreadline-prefix=$(STAGING_DIR)

ifeq ($(BR2_PACKAGE_JSON_C),y)
POKE_DEPENDENCIES += json-c
POKE_CONF_OPTS += --enable-mi
else
POKE_CONF_OPTS += --disable-mi
endif

$(eval $(autotools-package))
