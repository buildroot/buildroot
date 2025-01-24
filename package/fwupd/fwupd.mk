################################################################################
#
# fwupd
#
################################################################################

FWUPD_VERSION = 2.0.4
FWUPD_SITE = https://github.com/fwupd/fwupd/releases/download/$(FWUPD_VERSION)
FWUPD_SOURCE = fwupd-$(FWUPD_VERSION).tar.xz
FWUPD_LICENSE = LGPL-2.1+
FWUPD_LICENSE_FILES = COPYING
FWUPD_DEPENDENCIES = \
	host-pkgconf \
	host-python-jinja2 \
	libglib2 \
	libjcat \
	libusb \
	libxmlb \
	zlib

FWUPD_CONF_OPTS = \
	-Dstatic_analysis=false \
	-Dconsolekit=disabled \
	-Dfirmware-packager=true \
	-Ddocs=disabled \
	-Dlvfs=true \
	-Dman=false \
	-Dpassim=disabled \
	-Dp2p_policy=none \
	-Dcbor=disabled \
	-Dplugin_acpi_phat=enabled \
	-Dplugin_android_boot=enabled \
	-Dplugin_bcm57xx=enabled \
	-Dplugin_cfu=disabled \
	-Dplugin_emmc=enabled \
	-Dplugin_ep963x=enabled \
	-Dplugin_fastboot=disabled \
	-Dplugin_igsc=enabled \
	-Dplugin_intel_me=enabled \
	-Dplugin_kinetic_dp=enabled \
	-Dplugin_logitech_bulkcontroller=disabled \
	-Dplugin_logitech_scribe=disabled \
	-Dplugin_logitech_tap=disabled \
	-Dplugin_mediatek_scaler=enabled \
	-Dplugin_mtd=enabled \
	-Dplugin_nitrokey=enabled \
	-Dplugin_parade_lspcon=enabled \
	-Dplugin_pixart_rf=enabled \
	-Dplugin_powerd=enabled \
	-Dplugin_realtek_mst=enabled \
	-Dplugin_scsi=enabled \
	-Dplugin_synaptics_mst=enabled \
	-Dplugin_tpm=disabled \
	-Dplugin_uefi_capsule=enabled \
	-Dplugin_uefi_capsule_splash=false \
	-Dplugin_uf2=enabled \
	-Dplugin_upower=enabled \
	-Dqubes=false \
	-Dsupported_build=enabled \
	-Dlaunchd=disabled \
	-Dtests=false \
	-Dumockdev_tests=disabled \
	-Dmetainfo=true \
	-Dfish_completion=false \
	-Dudev=enabled \
	-Dvendor_ids_dir=/usr/share/hwdata \
	-Dvendor_metadata=false \
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
else
FWUPD_CONF_OPTS += -Dlzma=disabled
endif

ifeq ($(BR2_PACKAGE_LIBDRM_AMDGPU),y)
FWUPD_DEPENDENCIES += libdrm
FWUPD_CONF_OPTS += -Dlibdrm=enabled -Dplugin_amdgpu=enabled
else
FWUPD_CONF_OPTS += -Dlibdrm=disabled -Dplugin_amdgpu=disabled
endif

ifeq ($(BR2_PACKAGE_UTIL_LINUX_LIBBLKID),y)
FWUPD_DEPENDENCIES += util-linux
FWUPD_CONF_OPTS += -Dblkid=enabled
else
FWUPD_CONF_OPTS += -Dblkid=disabled
endif

ifeq ($(BR2_PACKAGE_VALGRIND),y)
FWUPD_DEPENDENCIES += valgrind
FWUPD_CONF_OPTS += -Dvalgrind=enabled
else
FWUPD_CONF_OPTS += -Dvalgrind=disabled
endif

ifeq ($(BR2_i386)$(BR2_x86_64),y)
FWUPD_CONF_OPTS += -Dplugin_cpu=enabled -Dplugin_msr=enabled -Dhsi=enabled
else
FWUPD_CONF_OPTS += -Dplugin_cpu=disabled -Dplugin_msr=disabled -Dhsi=disabled
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
FWUPD_DEPENDENCIES += gnutls
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

ifeq ($(BR2_PACKAGE_LIBMBIM)$(BR2_PACKAGE_LIBQMI)$(BR2_PACKAGE_MODEM_MANAGER),yyyy)
FWUPD_DEPENDENCIES += libmbim libqmi modem-manager
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

# plugin_nvme needs <linux/nvme_ioctl.h> (introduced in Kernel v4.5)
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_5),y)
FWUPD_CONF_OPTS += -Dplugin_nvme=enabled
else
FWUPD_CONF_OPTS += -Dplugin_nvme=disabled
endif

# plugin_gpio needs <linux/gpio.h> and GPIOv2 interface (introduced in
# Kernel v5.10)
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_5_10),y)
FWUPD_CONF_OPTS += -Dplugin_gpio=enabled
else
FWUPD_CONF_OPTS += -Dplugin_gpio=disabled
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
FWUPD_DEPENDENCIES += systemd
FWUPD_CONF_OPTS += -Dsystemd=enabled -Dsystemd_syscall_filter=true -Delogind=enabled
else
FWUPD_CONF_OPTS += -Dsystemd=disabled -Dsystemd_syscall_filter=false -Delogind=disabled
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
