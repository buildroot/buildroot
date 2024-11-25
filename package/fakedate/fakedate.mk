################################################################################
#
# fakedate
#
################################################################################

# source included in buildroot
HOST_FAKEDATE_LICENSE = GPL-2.0+

# The package is a dependency to ccache so ccache cannot be a dependency
HOST_FAKEDATE_ADD_CCACHE_DEPENDENCY = NO

define HOST_FAKEDATE_INSTALL_CMDS
	$(INSTALL) -D -m 755 package/fakedate/fakedate $(HOST_DIR)/bin/date
endef

$(eval $(host-generic-package))
