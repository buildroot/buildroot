################################################################################
#
# apl-core-library
#
################################################################################

APL_CORE_LIBRARY_VERSION = v1.2
APL_CORE_LIBRARY_SITE =  $(call github,alexa,apl-core-library,$(APL_CORE_LIBRARY_VERSION))
APL_CORE_LIBRARY_LICENSE = Apache-2.0
APL_CORE_LIBRARY_LICENSE_FILES = LICENSE.txt
APL_CORE_LIBRARY_DEPENDENCIES = host-cmake
APL_CORE_LIBRARY_INSTALL_STAGING = YES
APL_CORE_LIBRARY_INSTALL_TARGET = NO


$(eval $(cmake-package))
