################################################################################
#
# libmpsse
#
################################################################################

LIBMPSSE_VERSION = a2eafa24a3446a711b13523ec06c17b5a1c6cdc1
LIBMPSSE_SITE_METHOD = git
LIBMPSSE_SITE = https://github.com/devttys0/libmpsse.git
LIBMPSSE_INSTALL_STAGING = YES
LIBMPSSE_AUTORECONF = YES
LIBMPSSE_AUTORECONF_OPTS = "-I$(@D)/cfg"

LIBMPSSE_DEPENDENCIES = libftdi host-swig

LIBMPSSE_CONF_OPTS = \
	--prefix=/usr/ \
	 --disable-python

define LIBMPSSE_RUN_AUTOCONF
    cp -a $(@D)/src/* $(@D)
	mkdir -p $(@D)/cfg
endef
LIBMPSSE_PRE_CONFIGURE_HOOKS += LIBMPSSE_RUN_AUTOCONF

define LIBMPSSE_ENTER_BUILD_DIR
	cd $(@D)/src
endef
LIBMPSSE_PRE_BUILD_HOOKS += LIBMPSSE_ENTER_BUILD_DIR

$(eval $(autotools-package))
