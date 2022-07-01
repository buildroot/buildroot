################################################################################
#
# safeclib
#
################################################################################

SAFECLIB_VERSION = 60786283fd61cd621a5d1df00e083a1c1e3cf52a
SAFECLIB_SITE_METHOD = git
SAFECLIB_SITE = https://github.com/rurban/safeclib
SAFECLIB_LICENSE = MIT
SAFECLIB_LICENSE_FILES = COPYING
SAFECLIB_INSTALL_STAGING = YES

define SAFECLIB_RUN_AUTORECONF
        cd $(@D) && $(HOST_DIR)/usr/bin/autoreconf --force --install
endef
SAFECLIB_PRE_CONFIGURE_HOOKS += SAFECLIB_RUN_AUTORECONF

SAFECLIB_CONF_OPTS = \
    --disable-wchar

$(eval $(autotools-package))
