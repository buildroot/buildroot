################################################################################
#
# git-submodule-enabled
#
################################################################################

GIT_SUBMODULE_ENABLED_VERSION = a9dbc1e23c45e8e1b88c0448763f54d714eb6f8f
GIT_SUBMODULE_ENABLED_SITE = $(GITREMOTE_DIR)/repo.git
GIT_SUBMODULE_ENABLED_SITE_METHOD = git
GIT_SUBMODULE_ENABLED_GIT_SUBMODULES = YES

$(eval $(generic-package))
