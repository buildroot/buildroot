################################################################################
#
# good
#
################################################################################

GOOD_VERSION = a238b1dfcd825d47d834af3c5223417c8411d90d
GOOD_SITE = $(GITREMOTE_DIR)/repo.git
GOOD_SITE_METHOD = git

$(eval $(generic-package))
