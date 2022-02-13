################################################################################
#
# dt-utils
#
################################################################################

DT_UTILS_VERSION = 2021.03.0
DT_UTILS_SOURCE = dt-utils-$(DT_UTILS_VERSION).tar.xz
DT_UTILS_SITE = https://git.pengutronix.de/cgit/tools/dt-utils/snapshot
DT_UTILS_LICENSE = GPL-2.0
DT_UTILS_LICENSE_FILES = COPYING
DT_UTILS_DEPENDENCIES = udev
DT_UTILS_AUTORECONF = YES

$(eval $(autotools-package))
