################################################################################
#
# yaml-cpp
#
################################################################################

YAML_CPP_VERSION = 0.7.0
YAML_CPP_SITE = $(call github,jbeder,yaml-cpp,yaml-cpp-$(YAML_CPP_VERSION))
YAML_CPP_INSTALL_STAGING = YES
YAML_CPP_LICENSE = MIT
YAML_CPP_LICENSE_FILES = LICENSE
YAML_CPP_CPE_ID_VENDOR = yaml-cpp_project

# Disable testing and parse tools
YAML_CPP_CONF_OPTS += \
	-DYAML_CPP_BUILD_TESTS=OFF \
	-DYAML_CPP_BUILD_TOOLS=OFF

$(eval $(cmake-package))
