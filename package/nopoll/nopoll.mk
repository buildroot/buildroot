################################################################################
#
# nopoll
#
################################################################################

NOPOLL_VERSION = 0e1b4850d763252636875a599a27ae76463c8152
NOPOLL_SITE_METHOD = git
NOPOLL_SITE = git://github.com/Comcast/nopoll.git
NOPOLL_INSTALL_STAGING = YES
NOPOLL_DEPENDENCIES = host-autoconf
NOPOLL_AUTORECONF = YES

define NOPOLL_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
NOPOLL_PRE_CONFIGURE_HOOKS += NOPOLl_RUN_AUTOGEN

NOPOLL_CONF_OPTS += LIBS=-lpthread

$(eval $(autotools-package))
