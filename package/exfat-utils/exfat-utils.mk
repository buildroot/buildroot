################################################################################
#
# exfat-utils
#
################################################################################

EXFAT_UTILS_VERSION = 1.4.0
EXFAT_UTILS_SITE = https://github.com/relan/exfat/releases/download/v$(EXFAT_UTILS_VERSION)
EXFAT_UTILS_LICENSE = GPL-2.0+
EXFAT_UTILS_LICENSE_FILES = COPYING
EXFAT_UTILS_CPE_ID_VENDOR = exfat_project
EXFAT_UTILS_CPE_ID_PRODUCT = exfat

EXFAT_UTILS_CONF_OPTS += --exec-prefix=/

$(eval $(autotools-package))
