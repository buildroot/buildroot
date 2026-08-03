################################################################################
#
# qbe
#
################################################################################

QBE_VERSION = 1.2
QBE_SITE = https://c9x.me/compile/release
QBE_SOURCE = qbe-$(QBE_VERSION).tar.xz
QBE_LICENSE = MIT
QBE_LICENSE_FILES = LICENSE

define HOST_QBE_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOST_QBE_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) \
		PREFIX="$(HOST_DIR)" install
endef

$(eval $(host-generic-package))
