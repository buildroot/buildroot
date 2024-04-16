################################################################################
#
# mmc-utils
#
################################################################################

MMC_UTILS_VERSION = e1281d4de9166b7254ba30bb58f9191fc2c9e7fb
MMC_UTILS_SITE = https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git
MMC_UTILS_SITE_METHOD = git
MMC_UTILS_LICENSE = GPL-2.0
MMC_UTILS_LICENSE_FILES = README

MMC_UTILS_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_PACKAGE_MMC_UTILS_ENABLE_DANGEROUS_COMMANDS),y)
MMC_UTILS_CFLAGS += -DDANGEROUS_COMMANDS_ENABLED
endif

# override AM_CFLAGS as the project Makefile uses it to pass
# -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2, and the latter conflicts
# with the _FORTIFY_SOURCE that we pass when hardening options are
# enabled. Starting from commit:
# https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/commit/?id=958227890690290ee766aaad1b92f3413f67048c
# they use AM_CFLAGS to set VERSION to first 6 digit of git SHA1, so
# let's do this here otherwise it won't be automatically set and build
# will fail
define MMC_UTILS_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(MMC_UTILS_CFLAGS)" \
		AM_CFLAGS='-DVERSION=\"$(shell echo $(MMC_UTILS_VERSION) | head -c 6)\"'
endef

define MMC_UTILS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) prefix=/usr DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
