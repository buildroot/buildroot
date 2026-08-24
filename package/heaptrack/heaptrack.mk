################################################################################
#
# heaptrack
#
################################################################################

HEAPTRACK_SITE_METHOD = git
HEAPTRACK_SITE = https://invent.kde.org/sdk/heaptrack.git
HEAPTRACK_VERSION = 3e6cce3d210a6672fe6f92de0bed567c49b7a9c5
HEAPTRACK_LICENSE = LGPL-2.1-or-later, GPL-2.0-or-later (heaptrack_interpret)
HEAPTRACK_LICENSE_FILES = \
	LICENSES/LGPL-2.1-only.txt \
	LICENSES/GPL-2.0-or-later.txt \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/BSL-1.0.txt \
	LICENSES/MIT.txt \
	LICENSES/Apache-2.0.txt \
	LICENSES/BSD-3-Clause.txt
HEAPTRACK_DEPENDENCIES = host-pkgconf boost elfutils libunwind zlib
HEAPTRACK_CONF_OPTS = -DHEAPTRACK_BUILD_GUI=OFF -DHEAPTRACK_BUILD_PRINT=ON

ifeq ($(BR2_PACKAGE_ZSTD),y)
HEAPTRACK_DEPENDENCIES += zstd
endif

$(eval $(cmake-package))
