################################################################################
#
# isocline
#
################################################################################

ISOCLINE_VERSION = 1.1.0
ISOCLINE_SITE = $(call github,daanx,isocline,v$(ISOCLINE_VERSION))
ISOCLINE_LICENSE = MIT
ISOCLINE_LICENSE_FILES = LICENSE
ISOCLINE_INSTALL_STAGING = YES
ISOCLINE_CONF_OPTS = -DIC_BUILD_TESTS=OFF

$(eval $(cmake-package))
