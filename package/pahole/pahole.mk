################################################################################
#
# pahole
#
################################################################################

PAHOLE_VERSION = v1.23
PAHOLE_SITE = git://git.kernel.org/pub/scm/devel/pahole/pahole.git
PAHOLE_SITE_METHOD = git
# pahole contains git submodule and relies on them to be built.
PAHOLE_GIT_SUBMODULES = YES
HOST_PAHOLE_DEPENDENCIES = host-elfutils
# Defining __LIB is needed to build pahole.
HOST_PAHOLE_CONF_OPTS = -D__LIB=lib
PAHOLE_LICENSE = GPL-2.0
PAHOLE_LICENSE_FILES = COPYING

$(eval $(host-cmake-package))
