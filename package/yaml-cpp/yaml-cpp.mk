################################################################################
#
# yaml-cpp
#
################################################################################

YAML_CPP_VERSION = 0.8.0
YAML_CPP_SITE = $(call github,jbeder,yaml-cpp,$(YAML_CPP_VERSION))
YAML_CPP_INSTALL_STAGING = YES
YAML_CPP_LICENSE = MIT
YAML_CPP_LICENSE_FILES = LICENSE
YAML_CPP_CPE_ID_VALID = YES

# Disable testing and parse tools
YAML_CPP_CONF_OPTS += \
	-DCMAKE_DEBUG_POSTFIX="" \
	-DYAML_CPP_BUILD_TESTS=OFF \
	-DYAML_CPP_BUILD_TOOLS=OFF

$(eval $(cmake-package))
