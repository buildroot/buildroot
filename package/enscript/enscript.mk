################################################################################
#
# enscript
#
################################################################################

ENSCRIPT_VERSION = 1.6.6
ENSCRIPT_SITE = $(BR2_GNU_MIRROR)/enscript
ENSCRIPT_LICENSE = GPL-3.0+
ENSCRIPT_LICENSE_FILES = COPYING
ENSCRIPT_CPE_ID_VENDOR = gnu
# 0002-Add-CFLAG-std-c89-so-it-compiles-with-the-old-standa.patch
# 0003-Automake-1.12-and-up-no-longer-supports-pre-ANSI.patch
# 0005-Use-std-gnu89-instead-of-std-c89.patch
ENSCRIPT_AUTORECONF = YES

# Enable pthread threads if toolchain supports threads
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
ENSCRIPT_CONF_OPTS += --enable-threads=pth
else
ENSCRIPT_CONF_OPTS += --disable-threads
endif

$(eval $(autotools-package))
