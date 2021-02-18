################################################################################
#
# bridge-tools
#
################################################################################

HOST_BRIDGE_TOOLS_VERSION = trunk
HOST_BRIDGE_TOOLS_SITE_METHOD = git
HOST_BRIDGE_TOOLS_SITE = git@git.integraal.info:Integraal/framework
HOST_BRIDGE_TOOLS_INSTALL_STAGING = YES
HOST_BRIDGE_TOOLS_INSTALL_TARGET = NO

HOST_BRIDGE_TOOLS_DEPENDENCIES = host-cmake host-python3 host-python3-jsonref

HOST_BRIDGE_TOOLS_SUBDIR = tools

$(eval $(host-cmake-package))
