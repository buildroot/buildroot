################################################################################
#
# libspdm
#
################################################################################

LIBSPDM_VERSION = 3.1.1
LIBSPDM_SITE = $(call github,DMTF,libspdm,$(LIBSPDM_VERSION))
LIBSPDM_LICENSE = BSD-3-Clause
LIBSPDM_LICENSE_FILES = LICENSE.md
LIBSPDM_CPE_ID_VENDOR = dmtf

LIBSPDM_INSTALL_STAGING = YES
LIBSPDM_INSTALL_TARGET = NO

LIBSPDM_DEPENDENCIES = openssl

LIBSPDM_TARGET_CPU_FAMILY = $(call qstrip,$(BR2_PACKAGE_LIBSPDM_CPU_FAMILY))

LIBSPDM_CONF_OPTS = \
	-DARCH=$(LIBSPDM_TARGET_CPU_FAMILY) \
	-DTOOLCHAIN=NONE \
	-DTARGET=Release \
	-DCRYPTO=openssl \
	-DENABLE_BINARY_BUILD=1 \
	-DCOMPILED_LIBCRYPTO_PATH=/usr/lib/ \
	-DCOMPILED_LIBSSL_PATH=/usr/lib/ \
	-DDISABLE_TESTS=1 \
	-DDISABLE_EDDSA=1 \
	-DLINK_FLAGS=$(STAGING_DIR)

define LIBSPDM_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/lib
	cp -dpfr $(@D)/lib/* $(STAGING_DIR)/usr/lib/

	mkdir -p $(STAGING_DIR)/usr/include/libspdm/
	cp -dpfr $(@D)/include/* $(STAGING_DIR)/usr/include/libspdm/

	mkdir -p $(STAGING_DIR)/usr/include/libspdm/os_stub/spdm_crypt_ext_lib
	cp -dpfr $(@D)/os_stub/spdm_crypt_ext_lib/*.h \
		$(STAGING_DIR)/usr/include/libspdm/os_stub/spdm_crypt_ext_lib/
endef

$(eval $(cmake-package))
