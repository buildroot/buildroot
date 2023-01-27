################################################################################
#
# fxdiv
#
################################################################################

FXDIV_VERSION = 63058eff77e11aa15bf531df5dd34395ec3017c8
FXDIV_SITE = $(call github,Maratyszcza,FXdiv,$(FXDIV_VERSION))
FXDIV_LICENSE = MIT
FXDIV_LICENSE_FILES = LICENSE
FXDIV_INSTALL_STAGING = YES
# Only installs a header
FXDIV_INSTALL_TARGET = NO

FXDIV_CONF_OPTS = \
	-DFXDIV_BUILD_TESTS=OFF \
	-DFXDIV_BUILD_BENCHMARKS=OFF

$(eval $(cmake-package))
