################################################################################
#
# libubootenv
#
################################################################################

LIBUBOOTENV_VERSION = 86bd30a14e153a18f670b25708795253d8736f0f
LIBUBOOTENV_SITE = $(call github,sbabic,libubootenv,$(LIBUBOOTENV_VERSION))
LIBUBOOTENV_LICENSE = LGPL-2.1
LIBUBOOTENV_LICENSE_FILES = Licenses/lgpl-2.1.txt
LIBUBOOTENV_INSTALL_STAGING = YES
LIBUBOOTENV_DEPENDENCIES = zlib

$(eval $(cmake-package))
