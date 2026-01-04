################################################################################
#
# e2tools
#
################################################################################

E2TOOLS_VERSION = 0.1.2
E2TOOLS_SITE = https://github.com/e2tools/e2tools/releases/download/v$(E2TOOLS_VERSION)

E2TOOLS_LICENSE = GPL-2.0
E2TOOLS_LICENSE_FILES = COPYING
E2TOOLS_DEPENDENCIES = e2fsprogs
E2TOOLS_CONF_ENV = LIBS="-lpthread"
HOST_E2TOOLS_DEPENDENCIES = host-e2fsprogs
HOST_E2TOOLS_CONF_ENV = LIBS="-lpthread"

$(eval $(autotools-package))
$(eval $(host-autotools-package))
