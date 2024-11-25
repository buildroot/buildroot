################################################################################
#
# fwupd
#
################################################################################

FWUPD_VERSION = 1.9.20
FWUPD_SITE = https://github.com/fwupd/fwupd/releases/download/$(FWUPD_VERSION)
FWUPD_SOURCE = fwupd-$(FWUPD_VERSION).tar.xz
FWUPD_LICENSE = LGPL-2.1+
FWUPD_LICENSE_FILES = COPYING
FWUPD_DEPENDENCIES = \
	host-pkgconf \
	host-python-jinja2 \
	libglib2 \
	libjcat \
	libxmlb \
	zlib

FWUPD_CONF_OPTS = \
	-Dstatic_analysis=false \
	-Dconsolekit=disabled \
	-Dfirmware-packager=true \
	-Ddocs=disabled \
	-Dlvfs=true \
	-Dman=false \
	-Dgusb=disabled \
	-Dpassim=disabled \
	-Dp2p_policy=none \
	-Dcbor=disabled \
	-Dplugin_acpi_phat=enabled \
	-Dplugin_cfu=disabled \
	-Dplugin_ep963x=enabled \
	-Dplugin_fastboot=disabled \
	-Dplugin_logitech_bulkcontroller=disabled \
	-Dplugin_logitech_scribe=disabled \
	-Dplugin_logitech_tap=disabled \
	-Dplugin_pixart_rf=enabled \
	-Dplugin_tpm=disabled \
	-Dplugin_uefi_capsule=enabled \
	-Dplugin_uefi_capsule_splash=false \
	-Dplugin_nitrokey=enabled \
	-Dplugin_mtd=enabled \
	-Dplugin_intel_me=enabled \
	-Dplugin_upower=enabled \
	-Dplugin_powerd=enabled \
	-Dqubes=false \
	-Dsupported_build=enabled \
	-Dlaunchd=disabled \
	-Dtests=false \
	-Dmetainfo=true \
	-Dfish_completion=false \
	-Dcompat_cli=false \
	-Dthinklmi_compat=false \
	-Dpython="$(HOST_DIR)/bin/python3"

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
FWUPD_DEPENDENCIES += gobject-introspection
FWUPD_CONF_OPTS += -Dintrospection=enabled
else
FWUPD_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_PACKAGE_LIBARCHIVE),y)
FWUPD_DEPENDENCIES += libarchive
FWUPD_CONF_OPTS += -Dlibarchive=enabled
else
FWUPD_CONF_OPTS += -Dlibarchive=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGUDEV),y)
FWUPD_DEPENDENCIES += libgudev
FWUPD_CONF_OPTS += \
	-Dgudev=enabled \
	-Dplugin_android_boot=enabled \
	-Dplugin_bcm57xx=enabled \
	-Dplugin_emmc=enabled \
	-Dplugin_gpio=enabled \
	-Dplugin_igsc=enabled \
	-Dplugin_kinetic_dp=enabled \
	-Dplugin_parade_lspcon=enabled \
	-Dplugin_realtek_mst=enabled \
	-Dplugin_synaptics_mst=enabled \
	-Dplugin_mediatek_scaler=enabled \
	-Dplugin_scsi=enabled \
	-Dplugin_nvme=enabled \
	-Dplugin_uf2=enabled
else
FWUPD_CONF_OPTS += \
	-Dgudev=disabled \
	-Dplugin_android_boot=disabled \
	-Dplugin_bcm57xx=disabled \
	-Dplugin_emmc=disabled \
	-Dplugin_gpio=disabled \
	-Dplugin_igsc=disabled \
	-Dplugin_kinetic_dp=disabled \
	-Dplugin_parade_lspcon=disabled \
	-Dplugin_realtek_mst=disabled \
	-Dplugin_synaptics_mst=disabled \
	-Dplugin_mediatek_scaler=disabled \
	-Dplugin_scsi=disabled \
	-Dplugin_nvme=disabled \
	-Dplugin_uf2=disabled
endif

ifeq ($(BR2_PACKAGE_BLUEZ5_UTILS),y)
FWUPD_DEPENDENCIES += bluez5_utils
FWUPD_CONF_OPTS += -Dbluez=enabled
else
FWUPD_CONF_OPTS += -Dbluez=disabled
endif

ifeq ($(BR2_PACKAGE_POLKIT),y)
FWUPD_DEPENDENCIES += polkit
FWUPD_CONF_OPTS += -Dpolkit=enabled
else
FWUPD_CONF_OPTS += -Dpolkit=disabled
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
FWUPD_DEPENDENCIES += gnutls
FWUPD_CONF_OPTS += -Dgnutls=enabled -Dplugin_uefi_pk=enabled
else
FWUPD_CONF_OPTS += -Dgnutls=disabled -Dplugin_uefi_pk=disabled
endif

ifeq ($(BR2_PACKAGE_SQLITE),y)
FWUPD_DEPENDENCIES += sqlite
FWUPD_CONF_OPTS += -Dsqlite=enabled
else
FWUPD_CONF_OPTS += -Dsqlite=disabled
endif

ifeq ($(BR2_PACKAGE_XZ),y)
FWUPD_DEPENDENCIES += xz
FWUPD_CONF_OPTS += -Dlzma=enabled
ifeq ($(BR2_i386)$(BR2_x86_64),y)
FWUPD_CONF_OPTS += -Dplugin_intel_spi=true
else
FWUPD_CONF_OPTS += -Dplugin_intel_spi=false
endif
else
FWUPD_CONF_OPTS += -Dlzma=disabled -Dplugin_intel_spi=false
endif

ifeq ($(BR2_PACKAGE_LIBDRM_AMDGPU)$(BR2_PACKAGE_LIBGUDEV),yy)
FWUPD_DEPENDENCIES += libdrm libgudev
FWUPD_CONF_OPTS += -Dplugin_amdgpu=enabled
else
FWUPD_CONF_OPTS += -Dplugin_amdgpu=disabled
endif

ifeq ($(BR2_i386)$(BR2_x86_64),y)
FWUPD_CONF_OPTS += -Dplugin_cpu=enabled -Dplugin_msr=enabled -Dhsi=enabled
else
FWUPD_CONF_OPTS += -Dplugin_cpu=disabled -Dplugin_msr=disabled -Dhsi=disabled
endif

ifeq ($(BR2_PACKAGE_GNUTLS)$(BR2_PACKAGE_LIBGUDEV),yy)
FWUPD_DEPENDENCIES += gnutls libgudev
FWUPD_CONF_OPTS += -Dplugin_synaptics_rmi=enabled
else
FWUPD_CONF_OPTS += -Dplugin_synaptics_rmi=disabled
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
FWUPD_DEPENDENCIES += libcurl
FWUPD_CONF_OPTS += -Dplugin_redfish=enabled -Dcurl=enabled
else
FWUPD_CONF_OPTS += -Dplugin_redfish=disabled -Dcurl=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGUDEV)$(BR2_PACKAGE_LIBMBIM)$(BR2_PACKAGE_LIBQMI)$(BR2_PACKAGE_MODEM_MANAGER),yyyy)
FWUPD_DEPENDENCIES += libgudev libmbim libqmi modem-manager
FWUPD_CONF_OPTS += -Dplugin_modem_manager=enabled
else
FWUPD_CONF_OPTS += -Dplugin_modem_manager=disabled
endif

ifeq ($(BR2_PACKAGE_FLASHROM),y)
FWUPD_DEPENDENCIES += flashrom
FWUPD_CONF_OPTS += -Dplugin_flashrom=enabled
else
FWUPD_CONF_OPTS += -Dplugin_flashrom=disabled
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
FWUPD_DEPENDENCIES += systemd
FWUPD_CONF_OPTS += -Dsystemd=enabled -Delogind=enabled -Doffline=enabled
else
FWUPD_CONF_OPTS += -Dsystemd=disabled -Delogind=disabled -Doffline=disabled
endif

ifeq ($(BR2_PACKAGE_FWUPD_EFI),y)
FWUPD_DEPENDENCIES += fwupd-efi
FWUPD_CONF_OPTS += -Defi_binary=true
else
FWUPD_CONF_OPTS += -Defi_binary=false
endif

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
FWUPD_DEPENDENCIES += bash-completion
FWUPD_CONF_OPTS += -Dbash_completion=true
else
FWUPD_CONF_OPTS += -Dbash_completion=false
endif

$(eval $(meson-package))
