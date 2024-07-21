################################################################################
#
# parsec-tool
#
################################################################################

PARSEC_TOOL_VERSION = 0.7.0
PARSEC_TOOL_SITE = $(call github,parallaxsecond,parsec-tool,$(PARSEC_TOOL_VERSION))
PARSEC_TOOL_LICENSE = Apache-2.0
PARSEC_TOOL_LICENSE_FILES = LICENSE

$(eval $(cargo-package))
