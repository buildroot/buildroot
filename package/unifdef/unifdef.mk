################################################################################
#
# unifdef
#
################################################################################

UNIFDEF_VERSION = 2.12
UNIFDEF_SITE = https://dotat.at/prog/unifdef
UNIFDEF_LICENSE = BSD-2-Clause, BSD-3-Clause
UNIFDEF_LICENSE_FILES = COPYING

define HOST_UNIFDEF_BUILD_CMDS
	$(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define HOST_UNIFDEF_INSTALL_CMDS
	$(HOST_CONFIGURE_OPTS) $(MAKE) -C $(@D) prefix=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
