################################################################################
#
# nopoll
#
################################################################################

NOPOLL_VERSION = 41f9cd37cf3bf657a598e2330d99aad316f8d0dd
NOPOLL_SITE_METHOD = git
NOPOLL_SITE = https://github.com/Comcast/nopoll.git
NOPOLL_INSTALL_STAGING = YES
NOPOLL_DEPENDENCIES = host-autoconf
NOPOLL_AUTORECONF = YES

define NOPOLL_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
NOPOLL_PRE_CONFIGURE_HOOKS += NOPOLl_RUN_AUTOGEN

NOPOLL_CONF_OPTS += LIBS=-lpthread

$(eval $(autotools-package))
