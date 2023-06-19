################################################################################
#
# check
#
################################################################################

CHECK_VERSION = 0.15.2
CHECK_SITE = https://github.com/libcheck/check/releases/download/$(CHECK_VERSION)
CHECK_INSTALL_STAGING = YES
CHECK_DEPENDENCIES = host-pkgconf
CHECK_LICENSE = LGPL-2.1+
CHECK_LICENSE_FILES = COPYING.LESSER
CHECK_CONF_OPTS = -DBUILD_TESTING=OFF -DINSTALL_CHECKMK=OFF

$(eval $(cmake-package))
