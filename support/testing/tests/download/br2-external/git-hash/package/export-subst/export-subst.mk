################################################################################
#
# export-subst
#
################################################################################

EXPORT_SUBST_VERSION = 0fdb95cf4f3c5ed4003287649cabb33c5f843e26
EXPORT_SUBST_SITE = git://localhost:$(GITREMOTE_PORT_NUMBER)/repo.git

$(eval $(generic-package))
