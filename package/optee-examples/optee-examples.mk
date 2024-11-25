################################################################################
#
# optee-examples
#
################################################################################

OPTEE_EXAMPLES_VERSION = $(call qstrip,$(BR2_PACKAGE_OPTEE_EXAMPLES_VERSION))
OPTEE_EXAMPLES_LICENSE = BSD-2-Clause
OPTEE_EXAMPLES_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_OPTEE_EXAMPLES_CUSTOM_TARBALL),y)
OPTEE_EXAMPLES_TARBALL = $(call qstrip,$(BR2_PACKAGE_OPTEE_EXAMPLES_CUSTOM_TARBALL_LOCATION))
OPTEE_EXAMPLES_SITE = $(patsubst %/,%,$(dir $(OPTEE_EXAMPLES_TARBALL)))
OPTEE_EXAMPLES_SOURCE = $(notdir $(OPTEE_EXAMPLES_TARBALL))
else
OPTEE_EXAMPLES_SITE = $(call github,linaro-swg,optee_examples,$(OPTEE_EXAMPLES_VERSION))
endif

ifeq ($(BR2_PACKAGE_OPTEE_EXAMPLES):$(BR2_PACKAGE_OPTEE_EXAMPLES_LATEST),y:)
BR_NO_CHECK_HASH_FOR += $(OPTEE_EXAMPLES_SOURCE)
endif

OPTEE_EXAMPLES_DEPENDENCIES = optee-client optee-os

# Trusted Application are not built from CMake due to ta_dev_kit dependencies.
# We must build and install them on target.
define OPTEE_EXAMPLES_BUILD_TAS
	$(foreach f,$(wildcard $(@D)/*/ta/Makefile), \
		$(TARGET_CONFIGURE_OPTS) \
		$(MAKE) CROSS_COMPILE=$(TARGET_CROSS) \
			TA_DEV_KIT_DIR=$(OPTEE_OS_SDK) \
			O=out -C $(dir $f) all
	)
endef
define OPTEE_EXAMPLES_INSTALL_TAS
	@mkdir -p $(TARGET_DIR)/lib/optee_armtz
	@$(INSTALL) -D -m 444 -t $(TARGET_DIR)/lib/optee_armtz $(@D)/*/ta/out/*.ta
endef
OPTEE_EXAMPLES_POST_BUILD_HOOKS += OPTEE_EXAMPLES_BUILD_TAS
OPTEE_EXAMPLES_POST_INSTALL_TARGET_HOOKS += OPTEE_EXAMPLES_INSTALL_TAS

ifeq ($(BR2_PACKAGE_OPTEE_EXAMPLES_CUSTOM_TARBALL)$(BR_BUILDING),yy)
ifeq ($(call qstrip,$(BR2_PACKAGE_OPTEE_EXAMPLES_CUSTOM_TARBALL_LOCATION)),)
$(error No tarball location specified. Please check BR2_PACKAGE_OPTEE_EXAMPLES_CUSTOM_TARBALL_LOCATION)
endif
endif

$(eval $(cmake-package))
