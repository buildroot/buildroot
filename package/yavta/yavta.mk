################################################################################
#
# yavta
#
################################################################################

YAVTA_VERSION = 583bedefc2a247d2cfd32d1b4a0abbe3e2015c70
YAVTA_SITE = https://git.ideasonboard.org/yavta.git
YAVTA_SITE_METHOD = git
YAVTA_LICENSE = GPL-2.0+
YAVTA_LICENSE_FILES = COPYING.GPL
YAVTA_CONF_OPTS = -Dwerror=false

$(eval $(meson-package))
