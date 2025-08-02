################################################################################
#
# aichat
#
################################################################################

AICHAT_VERSION = 0.30.0
AICHAT_SITE = $(call github,sigoden,aichat,v$(AICHAT_VERSION))
AICHAT_LICENSE = Apache-2.0 or MIT
AICHAT_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT

$(eval $(cargo-package))
