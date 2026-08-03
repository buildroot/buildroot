################################################################################
#
# hare
#
################################################################################

HARE_VERSION = 0.26.0.1
HARE_SITE = https://git.sr.ht/~sircmpwn/hare/archive
HARE_SOURCE = $(HARE_VERSION).tar.gz
HARE_LICENSE = MPL-2.0
HARE_LICENSE_FILES = COPYING

HOST_HARE_DEPENDENCIES = host-harec host-qbe host-scdoc

ifeq ($(BR2_aarch64),y)
HOST_HARE_TARGET_ARCH = AARCH64
else ifeq ($(BR2_RISCV_64),y)
HOST_HARE_TARGET_ARCH = RISCV64
else ifeq ($(BR2_x86_64),y)
HOST_HARE_TARGET_ARCH = X86_64
endif

HOST_HARE_CONF_OPTS = \
	ARCH=$(HOSTARCH) \
	PREFIX="$(HOST_DIR)" \
	HAREC="$(HOST_DIR)/bin/harec" \
	QBE="$(HOST_DIR)/bin/qbe" \
	SCDOC="$(HOST_DIR)/bin/scdoc" \
	HAREPATH="$(HOST_DIR)/src/hare/stdlib" \
	$(HOST_HARE_TARGET_ARCH)_AS=$(TARGET_AS) \
	$(HOST_HARE_TARGET_ARCH)_CC=$(TARGET_CC) \
	$(HOST_HARE_TARGET_ARCH)_LD=$(TARGET_LD)

define HOST_HARE_CONFIGURE_CMDS
	cp $(@D)/configs/linux.mk $(@D)/config.mk
endef

define HOST_HARE_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) $(HOST_HARE_CONF_OPTS) all
endef

define HOST_HARE_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) $(HOST_HARE_CONF_OPTS) install
endef

$(eval $(host-generic-package))
