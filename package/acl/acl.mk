################################################################################
#
# acl
#
################################################################################

ACL_VERSION = 2.3.2
ACL_SOURCE = acl-$(ACL_VERSION).tar.xz
ACL_SITE = https://download.savannah.nongnu.org/releases/acl
ACL_LICENSE = GPL-2.0+ (programs), LGPL-2.1+ (libraries)
ACL_LICENSE_FILES = doc/COPYING doc/COPYING.LGPL
ACL_CPE_ID_VALID = YES

ACL_DEPENDENCIES = attr
HOST_ACL_DEPENDENCIES = host-attr

ACL_INSTALL_STAGING = YES

ACL_CONF_OPTS = --disable-nls

$(eval $(autotools-package))
$(eval $(host-autotools-package))
