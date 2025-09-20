################################################################################
#
# git-partial-sha1-tag-itself
#
################################################################################

GIT_PARTIAL_SHA1_TAG_ITSELF_VERSION = 2b0e0d98a49c97da6a61
GIT_PARTIAL_SHA1_TAG_ITSELF_SITE = $(GITREMOTE_DIR)/repo.git
GIT_PARTIAL_SHA1_TAG_ITSELF_SITE_METHOD = git
GIT_PARTIAL_SHA1_TAG_ITSELF_LICENSE_FILES = file

$(eval $(generic-package))
