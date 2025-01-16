################################################################################
#
# fwupd-efi
#
################################################################################

FWUPD_EFI_VERSION = 1.7
FWUPD_EFI_SITE = $(call github,fwupd,fwupd-efi,$(FWUPD_EFI_VERSION))
FWUPD_EFI_LICENSE = LGPL-2.1+
FWUPD_EFI_LICENSE_FILES = COPYING
FWUPD_EFI_INSTALL_STAGING = YES
FWUPD_EFI_DEPENDENCIES = host-python-pefile host-python-uswid gnu-efi
FWUPD_EFI_CONF_OPTS = \
	-Defi-libdir=$(STAGING_DIR)/usr/lib \
	-Defi-ldsdir=$(STAGING_DIR)/usr/lib \
	-Defi-includedir=$(STAGING_DIR)/usr/include/efi \
	-Defi_sbat_fwupd_generation=1 \
	-Defi_sbat_distro_id=buildroot \
	-Defi_sbat_distro_summary=Buildroot \
	-Defi_sbat_distro_pkgname=fwupd-efi \
	-Defi_sbat_distro_version=fwupd-efi-$(FWUPD_EFI_VERSION) \
	-Defi_sbat_distro_url=https://gitlab.com/buildroot.org/buildroot/-/tree/master/package/fwupd-efi \
	-Dgenpeimg=disabled \
	-Dpython="$(HOST_DIR)/bin/python3"
FWUPD_EFI_MESON_EXTRA_BINARIES = objcopy='$(TARGET_OBJCOPY)'

$(eval $(meson-package))
