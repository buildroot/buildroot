################################################################################
#
# harec
#
################################################################################

HAREC_VERSION = 0.26.0
HAREC_SITE = https://git.sr.ht/~sircmpwn/harec/archive
HAREC_SOURCE = $(HAREC_VERSION).tar.gz
HAREC_LICENSE = GPL-3.0
HAREC_LICENSE_FILES = COPYING

define HOST_HAREC_CONFIGURE_CMDS
	cp $(@D)/configs/linux.mk $(@D)/config.mk
endef

define HOST_HAREC_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) ARCH=$(HOSTARCH) all
endef

define HOST_HAREC_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) \
		PREFIX="$(HOST_DIR)" install
endef

$(eval $(host-generic-package))
