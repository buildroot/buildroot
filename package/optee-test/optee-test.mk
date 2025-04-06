################################################################################
#
# optee-test
#
################################################################################

OPTEE_TEST_VERSION = $(call qstrip,$(BR2_PACKAGE_OPTEE_TEST_VERSION))
OPTEE_TEST_LICENSE = GPL-2.0, BSD-2-Clause,
OPTEE_TEST_LICENSE_FILES = LICENSE-BSD LICENSE-GPL LICENSE.md

ifeq ($(BR2_PACKAGE_OPTEE_TEST_CUSTOM_TARBALL),y)
OPTEE_TEST_TARBALL = $(call qstrip,$(BR2_PACKAGE_OPTEE_TEST_CUSTOM_TARBALL_LOCATION))
OPTEE_TEST_SITE = $(patsubst %/,%,$(dir $(OPTEE_TEST_TARBALL)))
OPTEE_TEST_SOURCE = $(notdir $(OPTEE_TEST_TARBALL))
else
OPTEE_TEST_SITE = $(call github,OP-TEE,optee_test,$(OPTEE_TEST_VERSION))
endif

ifeq ($(BR2_PACKAGE_OPTEE_TEST):$(BR2_PACKAGE_OPTEE_TEST_LATEST),y:)
BR_NO_CHECK_HASH_FOR += $(OPTEE_TEST_SOURCE)
endif

OPTEE_TEST_DEPENDENCIES = optee-client optee-os

ifeq ($(BR2_PACKAGE_LIBOPENSSL),y)
OPTEE_TEST_DEPENDENCIES += libopenssl
endif

OPTEE_TEST_CONF_OPTS = -DOPTEE_TEST_SDK=$(OPTEE_OS_SDK)

# Trusted Application are not built from CMake due to ta_dev_kit
# dependencies. We must build and install them on target.
define OPTEE_TEST_BUILD_TAS
	$(foreach f,$(wildcard $(@D)/ta/*_lib/Makefile) $(wildcard $(@D)/ta/*/Makefile), \
		$(TARGET_CONFIGURE_OPTS) \
		$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) \
			TA_DEV_KIT_DIR=$(OPTEE_OS_SDK) \
			-C $(dir $f) all
	)
endef
define OPTEE_TEST_INSTALL_TAS
	@mkdir -p $(TARGET_DIR)/lib/optee_armtz
	@$(INSTALL) -D -m 444 -t $(TARGET_DIR)/lib/optee_armtz $(@D)/ta/*/*.ta
endef
OPTEE_TEST_POST_BUILD_HOOKS += OPTEE_TEST_BUILD_TAS
OPTEE_TEST_POST_INSTALL_TARGET_HOOKS += OPTEE_TEST_INSTALL_TAS

ifeq ($(BR2_PACKAGE_OPTEE_TEST_CUSTOM_TARBALL)$(BR_BUILDING),yy)
ifeq ($(call qstrip,$(BR2_PACKAGE_OPTEE_TEST_CUSTOM_TARBALL_LOCATION)),)
$(error No tarball location specified. Please check BR2_PACKAGE_OPTEE_TEST_CUSTOM_TARBALL_LOCATION)
endif
endif

$(eval $(cmake-package))
