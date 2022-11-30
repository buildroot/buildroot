################################################################################
#
# gitlab-helper-tag
#
################################################################################

GITLAB_HELPER_TAG_VERSION = 1.6.5
GITLAB_HELPER_TAG_SITE = $(call gitlab,solarus-games,solarus,v$(GITLAB_HELPER_TAG_VERSION))
GITLAB_HELPER_TAG_LICENSE_FILES = license.txt

$(eval $(generic-package))
