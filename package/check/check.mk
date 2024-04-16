################################################################################
#
# check
#
################################################################################

# This is the same as tag 0.15.2, but we can't use it, as to avoid conflict
# with the released tarball that was incomplete
CHECK_VERSION = 11970a7e112dfe243a2e68773f014687df2900e8
CHECK_SITE = $(call github,libcheck,check,$(CHECK_VERSION))
CHECK_INSTALL_STAGING = YES
CHECK_DEPENDENCIES = host-pkgconf
CHECK_LICENSE = LGPL-2.1+
CHECK_LICENSE_FILES = COPYING.LESSER
CHECK_CONF_OPTS = -DBUILD_TESTING=OFF -DINSTALL_CHECKMK=OFF

$(eval $(cmake-package))
