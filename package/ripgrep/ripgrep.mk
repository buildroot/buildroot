################################################################################
#
# ripgrep
#
################################################################################

RIPGREP_VERSION = 14.1.1
RIPGREP_SITE = $(call github,burntsushi,ripgrep,$(RIPGREP_VERSION))
RIPGREP_LICENSE = MIT
RIPGREP_LICENSE_FILES = LICENSE-MIT
RIPGREP_CPE_ID_VALID = YES

$(eval $(cargo-package))
