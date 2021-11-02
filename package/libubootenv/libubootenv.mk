################################################################################
#
# libubootenv
#
################################################################################

LIBUBOOTENV_VERSION = 7dbfffa4cc0e42ad3febb122a711fe9d1b20e9f7
LIBUBOOTENV_SITE = $(call github,sbabic,libubootenv,$(LIBUBOOTENV_VERSION))
LIBUBOOTENV_LICENSE = LGPL-2.1+, MIT, CC0-1.0
LIBUBOOTENV_LICENSE_FILES = LICENSES/CC0-1.0.txt \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/MIT.txt

LIBUBOOTENV_INSTALL_STAGING = YES
LIBUBOOTENV_DEPENDENCIES = zlib

$(eval $(cmake-package))
