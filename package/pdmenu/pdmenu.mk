################################################################################
#
# pdmenu
#
################################################################################

PDMENU_VERSION = 1.3.6
PDMENU_SITE = https://git.joeyh.name/index.cgi/pdmenu.git/snapshot
PDMENU_LICENSE = GPL-2.0
PDMENU_LICENSE_FILES = doc/COPYING
PDMENU_DEPENDENCIES = slang $(TARGET_NLS_DEPENDENCIES)
PDMENU_INSTALL_TARGET_OPTS = INSTALL_PREFIX=$(TARGET_DIR) install

# gcc-15 defaults to -std=gnu23 which introduces build failures.
# We force "-std=gnu17" for gcc version supporting it. Earlier gcc
# versions will work, since they are using the older standard.
ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_8),y)
PDMENU_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -std=gnu17"
endif

$(eval $(autotools-package))
