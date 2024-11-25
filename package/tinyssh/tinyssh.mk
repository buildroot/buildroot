################################################################################
#
# tinyssh
#
################################################################################

TINYSSH_VERSION = 20240101
TINYSSH_SITE = $(call github,janmojzis,tinyssh,$(TINYSSH_VERSION))
TINYSSH_LICENSE = CC0-1.0
TINYSSH_LICENSE_FILES = LICENCE

define TINYSSH_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) cross-compile
endef

define TINYSSH_INSTALL_TARGET_CMDS
	$(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
