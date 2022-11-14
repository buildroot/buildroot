################################################################################
#
# github-helper-hash
#
################################################################################

GITHUB_HELPER_HASH_VERSION = e2fba6457bd9d9c720540332eaf0c1f8c29eab00
GITHUB_HELPER_HASH_SITE = $(call github,buildroot,buildroot,$(GITHUB_HELPER_HASH_VERSION))
GITHUB_HELPER_HASH_LICENSE_FILES = COPYING

$(eval $(generic-package))
