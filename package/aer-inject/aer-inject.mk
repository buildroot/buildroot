################################################################################
#
# aer-inject
#
################################################################################

AER_INJECT_VERSION = 36d5b4f59b88c37d8ecba20b2302bddfe38f1ec2
AER_INJECT_SITE = https://github.com/intel/aer-inject.git
AER_INJECT_SITE_METHOD = git
AER_INJECT_LICENSE = GPL-2.0
AER_INJECT_LICENSE_FILES = LICENSE
AER_INJECT_DEPENDENCIES = host-flex host-bison

define AER_INJECT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS)
endef

define AER_INJECT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		DESTDIR=$(TARGET_DIR) PREFIX=/usr/bin install
endef

$(eval $(generic-package))
