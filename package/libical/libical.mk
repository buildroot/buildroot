################################################################################
#
# libical
#
################################################################################

LIBICAL_VERSION = 3.0.20
LIBICAL_SITE = https://github.com/libical/libical/releases/download/v$(LIBICAL_VERSION)
LIBICAL_INSTALL_STAGING = YES
LIBICAL_LICENSE = MPL-2.0 or LGPL-2.1
LIBICAL_LICENSE_FILES = LICENSE.MPL2.txt LICENSE.LGPL21.txt
LIBICAL_CPE_ID_VALID = YES
LIBICAL_DEPENDENCIES = host-perl

LIBICAL_CONF_OPTS = \
	-DGOBJECT_INTROSPECTION=OFF \
	-DICAL_BUILD_DOCS=OFF \
	-DICAL_GLIB=OFF \
	-DLIBICAL_BUILD_EXAMPLES=OFF \
	-DLIBICAL_BUILD_TESTING=OFF \
	-DWITH_CXX_BINDINGS=OFF
# building without this option is broken, it is used by
# Gentoo/alpinelinux as well
LIBICAL_CONF_OPTS += -DSHARED_ONLY=ON
# never build time zone info, always use system's tzinfo
LIBICAL_CONF_OPTS += -DUSE_BUILTIN_TZDATA=OFF

$(eval $(cmake-package))
