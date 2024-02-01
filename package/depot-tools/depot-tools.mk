################################################################################
#
# depot-tools
#
################################################################################

DEPOT_TOOLS_VERSION = 8d14454ba4a35fd9d2483842b08815a2357ec86f
DEPOT_TOOLS_SITE = https://chromium.googlesource.com/chromium/tools/depot_tools
DEPOT_TOOLS_SITE_METHOD = git
DEPOT_TOOLS_LICENSE = BSD-3-Clause
DEPOT_TOOLS_LICENSE_FILES = LICENSE

HOST_DEPOT_TOOLS_DEPENDENCIES = \
	host-python3 \
	host-python-httplib2 \
	host-python-pyparsing \
	host-python-six

define HOST_DEPOT_TOOLS_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/share/depot_tools
	cp -dprf $(@D)/* $(HOST_DIR)/share/depot_tools/
endef

$(eval $(host-generic-package))
