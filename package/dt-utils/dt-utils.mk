################################################################################
#
# dt-utils
#
################################################################################

DT_UTILS_VERSION = 2023.08.0
DT_UTILS_SOURCE = dt-utils-$(DT_UTILS_VERSION).tar.xz
DT_UTILS_SITE = https://git.pengutronix.de/cgit/tools/dt-utils/snapshot
DT_UTILS_LICENSE = CC0-1.0, GPL-2.0, GPL-2.0+, Zlib
DT_UTILS_LICENSE_FILES = \
	LICENSES/CC0-1.0.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-2.0-or-later.txt \
	LICENSES/Zlib.txt

DT_UTILS_DEPENDENCIES = udev
DT_UTILS_AUTORECONF = YES

$(eval $(autotools-package))
