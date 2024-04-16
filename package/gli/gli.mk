################################################################################
#
# gli
#
################################################################################

GLI_VERSION = 779b99ac6656e4d30c3b24e96e0136a59649a869
GLI_SITE = $(call github,g-truc,gli,$(GLI_VERSION))
GLI_LICENSE = MIT
GLI_LICENSE_FILES = manual.md

# GLI is a header-only library, it only makes sense
# to have it installed into the staging directory.
GLI_INSTALL_STAGING = YES
GLI_INSTALL_TARGET = NO

GLI_CONF_OPTS = -DGLI_TEST_ENABLE=OFF

$(eval $(cmake-package))
