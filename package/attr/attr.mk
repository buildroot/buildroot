################################################################################
#
# attr
#
################################################################################

ATTR_VERSION = 2.5.2
ATTR_SOURCE = attr-$(ATTR_VERSION).tar.xz
ATTR_SITE = http://download.savannah.gnu.org/releases/attr
ATTR_LICENSE = GPL-2.0+ (programs), LGPL-2.1+ (libraries)
ATTR_LICENSE_FILES = doc/COPYING doc/COPYING.LGPL
ATTR_CPE_ID_VALID = YES

# Flag added for patch dealing with symver in configure.ac
ATTR_AUTORECONF = YES

ATTR_INSTALL_STAGING = YES

ATTR_CONF_OPTS = --disable-nls

$(eval $(autotools-package))
$(eval $(host-autotools-package))
