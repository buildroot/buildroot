################################################################################
#
# export-subst
#
################################################################################

EXPORT_SUBST_VERSION = 0fdb95cf4f3c5ed4003287649cabb33c5f843e26
EXPORT_SUBST_SITE = $(GITREMOTE_DIR)/repo.git
EXPORT_SUBST_SITE_METHOD = git

$(eval $(generic-package))
