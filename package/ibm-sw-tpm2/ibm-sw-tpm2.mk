################################################################################
#
# ibm-sw-tpm2
#
################################################################################

IBM_SW_TPM2_VERSION = rev183-2024-03-27
IBM_SW_TPM2_SITE = https://git.code.sf.net/p/ibmswtpm2/tpm2
IBM_SW_TPM2_SITE_METHOD = git
IBM_SW_TPM2_LICENSE = BSD-3-Clause
IBM_SW_TPM2_LICENSE_FILES = LICENSE
IBM_SW_TPM2_DEPENDENCIES = openssl

define IBM_SW_TPM2_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/src $(TARGET_CONFIGURE_OPTS)
endef

define IBM_SW_TPM2_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/src $(TARGET_CONFIGURE_OPTS) install \
		DESTDIR=$(TARGET_DIR)
endef

$(eval $(generic-package))
