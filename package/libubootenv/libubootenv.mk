################################################################################
#
# libubootenv
#
################################################################################

LIBUBOOTENV_VERSION = 0.3.3
LIBUBOOTENV_SITE = $(call github,sbabic,libubootenv,v$(LIBUBOOTENV_VERSION))
LIBUBOOTENV_LICENSE = LGPL-2.1+, MIT, CC0-1.0
LIBUBOOTENV_LICENSE_FILES = LICENSES/CC0-1.0.txt \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/MIT.txt

LIBUBOOTENV_INSTALL_STAGING = YES
LIBUBOOTENV_DEPENDENCIES = zlib

$(eval $(cmake-package))
