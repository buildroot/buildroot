################################################################################
#
# scdoc
#
################################################################################

SCDOC_VERSION = 1.11.4
SCDOC_SITE = https://git.sr.ht/~sircmpwn/scdoc/archive
SCDOC_SOURCE = $(SCDOC_VERSION).tar.gz
SCDOC_LICENSE = MIT
SCDOC_LICENSE_FILES = COPYING

define HOST_SCDOC_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) all
endef

define HOST_SCDOC_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) \
		PREFIX="$(HOST_DIR)" install
endef

$(eval $(host-generic-package))
