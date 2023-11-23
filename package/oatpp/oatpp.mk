################################################################################
#
# oatpp
#
################################################################################

OATPP_VERSION = 1.3.0
OATPP_SITE = $(call github,oatpp,oatpp,$(OATPP_VERSION))
OATPP_LICENSE = Apache-2.0
OATPP_LICENSE_FILES = LICENSE
OATPP_CONF_OPTS = -DBUILD_SHARED_LIBS=OFF
OATPP_INSTALL_STAGING = YES
# Only builds a static lib and headers
OATPP_INSTALL_TARGET = NO

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS_NPTL),y)
OATPP_CONF_OPTS += -DOATPP_COMPAT_BUILD_NO_SET_AFFINITY=OFF
else
OATPP_CONF_OPTS += -DOATPP_COMPAT_BUILD_NO_SET_AFFINITY=ON
endif

$(eval $(cmake-package))
