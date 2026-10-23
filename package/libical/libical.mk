################################################################################
#
# libical
#
################################################################################

LIBICAL_VERSION = 4.0.7
LIBICAL_SITE = https://github.com/libical/libical/releases/download/v$(LIBICAL_VERSION)
LIBICAL_INSTALL_STAGING = YES
LIBICAL_LICENSE = MPL-2.0 or LGPL-2.1, BSD-3-Clause (icaldate), MIT-like (libicalvcal)
LIBICAL_LICENSE_FILES = \
	LICENSE.txt \
	LICENSES/MPL-2.0.txt \
	LICENSES/LGPL-2.1-only.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/LicenseRef-APPLEMIT.txt
LIBICAL_CPE_ID_VALID = YES
LIBICAL_DEPENDENCIES = host-perl

LIBICAL_CONF_OPTS = \
	-DLIBICAL_BUILD_DOCS=OFF \
	-DLIBICAL_BUILD_EXAMPLES=OFF \
	-DLIBICAL_BUILD_TESTING=OFF \
	-DLIBICAL_CXX_BINDINGS=OFF \
	-DLIBICAL_GLIB=OFF \
	-DLIBICAL_GOBJECT_INTROSPECTION=OFF \
	-DLIBICAL_JAVA_BINDINGS=OFF \
	-DLIBICAL_STATIC=OFF
# never build time zone info, always use system's tzinfo
LIBICAL_CONF_OPTS += -DLIBICAL_ENABLE_BUILTIN_TZDATA=OFF

$(eval $(cmake-package))
