################################################################################
#
# babeltrace2
#
################################################################################

BABELTRACE2_SITE = https://www.efficios.com/files/babeltrace
BABELTRACE2_VERSION = 2.1.2
BABELTRACE2_SOURCE = babeltrace2-$(BABELTRACE2_VERSION).tar.bz2
BABELTRACE2_LICENSE = \
	MIT, \
	BSD-2-Clause (C and Python TAP test libraries), \
	BSD-4-Clause (CRC32 code), \
	CC-BY-SA-4.0 (doc), \
	GPL-2.0 (test code), \
	GPL-3.0+ (BASH TAP library), \
	LGPL-2.1 (src/common/list.h), \
	PSF-2.0 (typing Python module)
BABELTRACE2_LICENSE_FILES = \
	LICENSE \
	LICENSES/MIT.txt \
	LICENSES/BSD-2-Clause.txt \
	LICENSES/BSD-4-Clause.txt \
	LICENSES/CC-BY-SA-4.0.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-or-later.txt \
	LICENSES/LGPL-2.1-only.txt \
	LICENSES/PSF-2.0.txt
BABELTRACE2_CONF_OPTS = --disable-man-pages
BABELTRACE2_DEPENDENCIES = libglib2 host-pkgconf
# The host-elfutils dependency is optional, but since we don't have
# options for host packages, just build support for it
# unconditionally.
HOST_BABELTRACE2_DEPENDENCIES = host-libglib2 host-pkgconf host-elfutils
HOST_BABELTRACE2_CONF_OPTS += --disable-man-pages --enable-debug-info

ifeq ($(BR2_PACKAGE_ELFUTILS),y)
BABELTRACE2_DEPENDENCIES += elfutils
BABELTRACE2_CONF_OPTS += --enable-debug-info
BABELTRACE2_CONF_ENV += bt_cv_lib_elfutils=yes
else
BABELTRACE2_CONF_OPTS += --disable-debug-info
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
BABELTRACE2_CONF_ENV += LIBS=-latomic
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
