################################################################################
#
# git-wrong-sha1
#
################################################################################

GIT_WRONG_SHA1_VERSION = 0000000000000000000000000000000000000000
GIT_WRONG_SHA1_SITE = $(GITREMOTE_DIR)/repo.git
GIT_WRONG_SHA1_SITE_METHOD = git
GIT_WRONG_SHA1_LICENSE_FILES = file

$(eval $(generic-package))
