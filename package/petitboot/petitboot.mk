################################################################################
#
# petitboot
#
################################################################################

PETITBOOT_VERSION = 1.13
PETITBOOT_SOURCE = petitboot-v$(PETITBOOT_VERSION).tar.gz
PETITBOOT_SITE = https://github.com/open-power/petitboot/releases/download/v$(PETITBOOT_VERSION)
PETITBOOT_DEPENDENCIES = elfutils ncurses udev host-bison host-flex lvm2
PETITBOOT_LICENSE = GPL-2.0
PETITBOOT_LICENSE_FILES = COPYING

PETITBOOT_CONF_OPTS = \
	--enable-crypt \
	--enable-platform-auto \
	--disable-mtd \
	--with-ncurses \
	--without-signed-boot \
	--without-twin-fbdev \
	--without-twin-x11 \
	$(if $(BR2_PACKAGE_BUSYBOX),--enable-busybox,--disable-busybox) \
	HOST_PROG_KEXEC=/usr/sbin/kexec \
	HOST_PROG_SHUTDOWN=/usr/sbin/kexec-restart

# HPA and Busybox tftp are supported. HPA tftp is part of Buildroot's tftpd
# package.
ifeq ($(BR2_PACKAGE_TFTPD),y)
PETITBOOT_CONF_OPTS += --with-tftp=hpa
else ifeq ($(BR2_PACKAGE_BUSYBOX),y)
PETITBOOT_CONF_OPTS += --with-tftp=busybox
else
# This actually means "autodetect", there's no way to really disable.
PETITBOOT_CONF_OPTS += --without-tftp
endif

ifeq ($(BR2_PACKAGE_DTC),y)
PETITBOOT_DEPENDENCIES += dtc
PETITBOOT_CONF_OPTS += --with-fdt
define PETITBOOT_POST_INSTALL_DTB
	$(INSTALL) -D -m 0755 $(@D)/utils/hooks/30-dtb-updates \
		$(TARGET_DIR)/etc/petitboot/boot.d/30-dtb-updates
endef
PETITBOOT_POST_INSTALL_TARGET_HOOKS += PETITBOOT_POST_INSTALL_DTB
else
PETITBOOT_CONF_OPTS += --without-fdt
endif

define PETITBOOT_POST_INSTALL
	$(INSTALL) -D -m 0755 $(@D)/utils/bb-kexec-reboot \
		$(TARGET_DIR)/usr/libexec/petitboot/bb-kexec-reboot
	$(INSTALL) -D -m 0755 $(@D)/utils/hooks/01-create-default-dtb \
		$(TARGET_DIR)/etc/petitboot/boot.d/01-create-default-dtb
	$(INSTALL) -D -m 0755 $(@D)/utils/hooks/90-sort-dtb \
		$(TARGET_DIR)/etc/petitboot/boot.d/90-sort-dtb
	$(INSTALL) -m 0755 -D $(PETITBOOT_PKGDIR)/S15pb-discover \
		$(TARGET_DIR)/etc/init.d/S15pb-discover
	mkdir -p $(TARGET_DIR)/usr/share/udhcpc/default.script.d/
	ln -sf /usr/sbin/pb-udhcpc \
		$(TARGET_DIR)/usr/share/udhcpc/default.script.d/
endef

PETITBOOT_POST_INSTALL_TARGET_HOOKS += PETITBOOT_POST_INSTALL

$(eval $(autotools-package))
