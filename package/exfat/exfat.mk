################################################################################
#
# exfat
#
################################################################################

EXFAT_VERSION = 1.4.0
EXFAT_SITE = https://github.com/relan/exfat/releases/download/v$(EXFAT_VERSION)
EXFAT_SOURCE = fuse-exfat-$(EXFAT_VERSION).tar.gz
EXFAT_DEPENDENCIES = \
	$(if $(BR2_PACKAGE_LIBFUSE3),libfuse3,libfuse) \
	host-pkgconf
EXFAT_LICENSE = GPL-2.0+
EXFAT_LICENSE_FILES = COPYING
EXFAT_CPE_ID_VALID = YES

EXFAT_CONF_OPTS += --exec-prefix=/

$(eval $(autotools-package))
