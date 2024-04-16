################################################################################
#
# cups-pk-helper
#
################################################################################

CUPS_PK_HELPER_VERSION = 0.2.7
CUPS_PK_HELPER_SITE = https://www.freedesktop.org/software/cups-pk-helper/releases
CUPS_PK_HELPER_SOURCE = cups-pk-helper-$(CUPS_PK_HELPER_VERSION).tar.xz
CUPS_PK_HELPER_LICENSE = GPL-2.0+
CUPS_PK_HELPER_LICENSE_FILES = COPYING
CUPS_PK_HELPER_CPE_ID_VALID = YES
CUPS_PK_HELPER_DEPENDENCIES = cups libglib2 polkit

$(eval $(meson-package))
