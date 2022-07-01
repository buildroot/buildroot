################################################################################
#
# libunpriv
#
################################################################################

LIBUNPRIV_VERSION = 10cb90eaa07788081d9bf629573a093cd106dc70
LIBUNPRIV_SITE_METHOD = git
LIBUNPRIV_SITE = https://code.rdkcentral.com/r/rdk/components/generic/libunpriv
LIBUNPRIV_INSTALL_STAGING = YES
LIBUNPRIV_DEPENDENCIES = libcap jsoncpp host-autoconf host-automake


define LIBUNPRIV_RUN_AUTORECONF
    cd $(@D) && $(HOST_DIR)/usr/bin/autoreconf -if
endef
LIBUNPRIV_PRE_CONFIGURE_HOOKS += LIBUNPRIV_RUN_AUTORECONF

LIBUNPRIV_CONF_OPTS = \
     --prefix=/usr/ \
     --disable-silent-rules

$(eval $(autotools-package))
$(eval $(host-autotools-package))
