################################################################################
#
# ruy
#
################################################################################

RUY_VERSION = 83fd40d730feb0804fafbc2d8814bcc19a17b2e5
RUY_SITE = $(call github,google,ruy,$(RUY_VERSION))
RUY_LICENSE = Apache-2.0
RUY_LICENSE_FILES = LICENSE
RUY_INSTALL_STAGING = YES
RUY_DEPENDENCIES = cpuinfo
RUY_CONF_OPTS = \
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	-DRUY_FIND_CPUINFO=ON \
	-DRUY_MINIMAL_BUILD=ON

$(eval $(cmake-package))
