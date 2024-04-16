################################################################################
#
# cli11
#
################################################################################

CLI11_VERSION = 2.3.2
CLI11_SITE = $(call github,CLIUtils,CLI11,v$(CLI11_VERSION))
CLI11_LICENSE = BSD-3-Clause
CLI11_LICENSE_FILES = LICENSE
CLI11_INSTALL_STAGING = YES
CLI11_INSTALL_TARGET = NO
CLI11_CONF_OPTS = -DCLI11_BUILD_DOCS=OFF -DCLI11_BUILD_EXAMPLES=OFF

$(eval $(cmake-package))
