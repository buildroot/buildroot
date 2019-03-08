################################################################################
#
# pxcore
#
################################################################################
PXCORE_DUKLUV_VERSION = 0db82d484abadebadeb3d8253b5a55924bcebaf8
PXCORE_DUKLUV_SITE_METHOD = git
PXCORE_DUKLUV_SITE = git://github.com/pxscene/pxCore
PXCORE_DUKLUV_INSTALL_STAGING = YES
PXCORE_DUKLUV_AUTORECONF = YES
PXCORE_DUKLUV_AUTORECONF_OPTS = "-Icfg"

PXCORE_DUKLUV_CONF_OPTS += \
    -DBUILD_PXCORE_LIBS=OFF \
    -DBUILD_PXSCENE=OFF \
    -DSUPPORT_DUKTAPE=ON -DBUILD_DUKTAPE=ON


$(eval $(cmake-package))
