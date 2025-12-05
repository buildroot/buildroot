################################################################################
#
# sysrepo-cpp
#
################################################################################

SYSREPO_CPP_VERSION = 6
SYSREPO_CPP_SITE = $(call github,sysrepo,sysrepo-cpp,v$(SYSREPO_CPP_VERSION))
SYSREPO_CPP_LICENSE = BSD-3-Clause
SYSREPO_CPP_LICENSE_FILES = LICENSE
SYSREPO_CPP_INSTALL_STAGING = YES
SYSREPO_CPP_SUPPORTS_IN_SOURCE_BUILD = NO
SYSREPO_CPP_DEPENDENCIES = sysrepo libyang-cpp

SYSREPO_CPP_CONF_OPTS += \
	-DWITH_DOCS=OFF \
	-DWITH_EXAMPLES=OFF

$(eval $(cmake-package))
