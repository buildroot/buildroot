################################################################################
#
# glm
#
################################################################################

GLM_VERSION = 1.0.0
GLM_SITE = $(call github,g-truc,glm,$(GLM_VERSION))
GLM_LICENSE = MIT
GLM_LICENSE_FILES = copying.txt

# GLM is a header-only library, it only makes sense
# to have it installed into the staging directory.
GLM_INSTALL_STAGING = YES
GLM_INSTALL_TARGET = NO

# Don't build libraries as GLM is header-only
GLM_CONF_OPTS = \
	-DGLM_TEST_ENABLE=OFF \
	-DGLM_BUILD_LIBRARY=OFF

$(eval $(cmake-package))
