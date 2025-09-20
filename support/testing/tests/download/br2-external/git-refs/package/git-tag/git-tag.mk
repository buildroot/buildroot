################################################################################
#
# git-tag
#
################################################################################

GIT_TAG_VERSION = mytag
GIT_TAG_SITE = $(GITREMOTE_DIR)/repo.git
GIT_TAG_SITE_METHOD = git
GIT_TAG_LICENSE_FILES = file

$(eval $(generic-package))
