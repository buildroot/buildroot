################################################################################
#
# gitlab-helper-hash
#
################################################################################

GITLAB_HELPER_HASH_VERSION = 21a378a7858460809ffef1c96a07a493d709730c
GITLAB_HELPER_HASH_SITE = $(call gitlab,solarus-games,solarus,$(GITLAB_HELPER_HASH_VERSION))

GITLAB_HELPER_HASH_LICENSE_FILES = license.txt

$(eval $(generic-package))
