################################################################################
#
# github-helper-tag
#
################################################################################

GITHUB_HELPER_TAG_VERSION = 2021.02
GITHUB_HELPER_TAG_SITE = $(call github,buildroot,buildroot,$(GITHUB_HELPER_TAG_VERSION))
GITHUB_HELPER_TAG_LICENSE_FILES = COPYING

$(eval $(generic-package))
