################################################################################
#
# git-sha1-reachable-by-tag
#
################################################################################

GIT_SHA1_REACHABLE_BY_TAG_VERSION = 46bae5b639e5a18e2cc4dc508f080d566baeff59
GIT_SHA1_REACHABLE_BY_TAG_SITE = $(GITREMOTE_DIR)/repo.git
GIT_SHA1_REACHABLE_BY_TAG_SITE_METHOD = git
GIT_SHA1_REACHABLE_BY_TAG_LICENSE_FILES = file

$(eval $(generic-package))
