################################################################################
#
# alchemy
#
################################################################################

ALCHEMY_VERSION = d95b3c38cd37814a1b98d0bbf813de7adaaecfbc
ALCHEMY_SITE = $(call github,Parrot-Developers,alchemy,$(ALCHEMY_VERSION))
ALCHEMY_LICENSE = BSD-3-Clause (Alchemy), GPL-2.0 (kconfig)
ALCHEMY_LICENSE_FILES = COPYING README
HOST_ALCHEMY_DEPENDENCIES = host-python3

ALCHEMY_HOME = $(HOST_DIR)/opt/alchemy
ALCHEMY_SDK_BASEDIR = $(STAGING_DIR)/usr/lib/alchemy/sdk

define HOST_ALCHEMY_INSTALL_CMDS
	mkdir -p $(ALCHEMY_HOME)
	cp -rf $(@D)/* $(ALCHEMY_HOME)
	cp $(HOST_ALCHEMY_PKGDIR)/atom.mk.in $(ALCHEMY_HOME)/atom.mk.in
endef

$(eval $(host-generic-package))

# Variables used by other packages

ALCHEMY_MAKE = $(ALCHEMY_HOME)/scripts/alchemake

# TARGET_ARCH is set to 'xxx' to avoid Alchemy managing the architecture.
# When Alchemy manages the architecture, it can add some flags to CFGLAGS and
# can lead to incorrect result with the toolchain provided in TARGET_CROSS.
# 'xxx' is an unknown architecture for Alchemy. Using this value is a simple
# way to disable the Alchemy architecture management.
ALCHEMY_TARGET_ENV = \
	$(TARGET_MAKE_ENV) \
	ALCHEMY_HOME=$(ALCHEMY_HOME) \
	ALCHEMY_WORKSPACE_DIR="$(@D)" \
	ALCHEMY_TARGET_OUT=alchemy-out \
	TARGET_OS=linux \
	TARGET_OS_FLAVOUR=buildroot \
	TARGET_CROSS="$(TARGET_CROSS)" \
	TARGET_ARCH=xxx \
	TARGET_GLOBAL_CXXFLAGS="$(TARGET_CXXFLAGS)" \
	TARGET_GLOBAL_LDFLAGS="$(TARGET_LDFLAGS)" \
	TARGET_GLOBAL_FFLAGS="$(TARGET_FCFLAGS)" \
	TARGET_GLOBAL_FCFLAGS="$(TARGET_FCFLAGS)"

ifeq ($(BR2_STATIC_LIBS),y)
ALCHEMY_TARGET_ENV += \
	TARGET_FORCE_STATIC=1 \
	TARGET_GLOBAL_CFLAGS="$(TARGET_CFLAGS)"
else
ALCHEMY_TARGET_ENV += \
	TARGET_GLOBAL_CFLAGS="$(TARGET_CFLAGS) -fPIC"
endif

# Install an Alchemy SDK file.
# This macro can be used by Alchemy packages
# $1: Alchemy module name
# $2: Alchemy module file name
# $3: Alchemy module libraries this module depends on
define ALCHEMY_INSTALL_LIB_SDK_FILE
	$(INSTALL) -m 0644 -D \
		$(ALCHEMY_HOME)/atom.mk.in \
		$(ALCHEMY_SDK_BASEDIR)/$($(PKG)_NAME)/atom.mk
	$(SED) 's#@STAGING_DIR@#$(STAGING_DIR)#' \
		-e 's#@MODULE@#$(strip $(1))#' \
		-e 's#@MODULE_FILENAME@#$(strip $(2))#' \
		-e 's#@LIBRARIES@#$(strip $(3))#' \
		$(ALCHEMY_SDK_BASEDIR)/$($(PKG)_NAME)/atom.mk
endef
