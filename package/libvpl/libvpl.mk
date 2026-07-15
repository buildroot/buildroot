################################################################################
#
# libvpl
#
################################################################################

LIBVPL_VERSION = 2.16.0
LIBVPL_SITE = $(call github,intel,libvpl,v$(LIBVPL_VERSION))
LIBVPL_LICENSE = MIT
LIBVPL_LICENSE_FILES = LICENSE
LIBVPL_INSTALL_STAGING = YES
LIBVPL_DEPENDENCIES = host-pkgconf

LIBVPL_CONF_OPTS = \
	-DBUILD_TOOLS=OFF \
	-DINSTALL_EXAMPLES=OFF

$(eval $(cmake-package))
