################################################################################
#
# lzop
#
################################################################################

LZOP_VERSION = 1.04
LZOP_SITE = http://www.lzop.org/download
LZOP_LICENSE = GPL-2.0+
LZOP_LICENSE_FILES = COPYING
LZOP_DEPENDENCIES = lzo
HOST_LZOP_DEPENDENCIES = host-lzo

# lzop uses libtool 2.4.2.418, which is right between 2.4.2 and
# 2.4.4. While our patch for 2.4 is also supposed to work up to and
# including 2.4.2.x, it does not work for libtool 2.4.2.418, which
# requires the patch for 2.4.4. So we disable the libtool patching
# from autotools-package and do our own.
LZOP_LIBTOOL_PATCH = NO

define LZOP_LIBTOOL_FIXUP
	patch -i support/libtool/buildroot-libtool-v2.4.4.patch $(@D)/autoconf/ltmain.sh
endef
LZOP_POST_PATCH_HOOKS += LZOP_LIBTOOL_FIXUP
HOST_LZOP_POST_PATCH_HOOKS += LZOP_LIBTOOL_FIXUP

$(eval $(autotools-package))
$(eval $(host-autotools-package))

LZOP = $(HOST_DIR)/bin/lzop
