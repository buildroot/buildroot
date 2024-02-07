################################################################################
#
# petitboot
#
################################################################################

PETITBOOT_VERSION = 1.15
PETITBOOT_SOURCE = petitboot-v$(PETITBOOT_VERSION).tar.gz
PETITBOOT_SITE = https://github.com/open-power/petitboot/releases/download/v$(PETITBOOT_VERSION)
PETITBOOT_DEPENDENCIES = \
	elfutils \
	ncurses \
	udev \
	host-bison \
	host-flex \
	lvm2 \
	$(if $(BR2_PACKAGE_LIBXCRYPT),libxcrypt) \
	$(TARGET_NLS_DEPENDENCIES)
PETITBOOT_LICENSE = GPL-2.0
PETITBOOT_LICENSE_FILES = COPYING

PETITBOOT_CONF_ENV = LDFLAGS="$(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)"
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
	HOST_PROG_SH=/usr/libexec/petitboot/pb-shell \
	HOST_PROG_SHUTDOWN=/usr/libexec/petitboot/kexec-restart

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

ifeq ($(BR2_INIT_BUSYBOX),y)
# inittab "restart" runlevel entry runs kexec
PETITBOOT_KEXEC_COMMAND = /bin/kill -QUIT 1
define PETITBOOT_BUSYBOX_INITTAB
	grep -q kexec $(TARGET_DIR)/etc/inittab || \
		printf "\nnull::restart:/usr/sbin/kexec -f -e\n" >> $(TARGET_DIR)/etc/inittab
endef
PETITBOOT_TARGET_FINALIZE_HOOKS += PETITBOOT_BUSYBOX_INITTAB
else ifeq ($(BR2_INIT_SYSV),y)
# inittab runlevel 6 entry runs kexec
PETITBOOT_KEXEC_COMMAND = /sbin/shutdown -r now
define PETITBOOT_SYSV_INITTAB
	grep -q kexec $(TARGET_DIR)/etc/inittab || \
		$(SED) 's~^reb0:.*~reb0:6:wait:/usr/sbin/kexec -f -e~' $(TARGET_DIR)/etc/inittab
endef
PETITBOOT_TARGET_FINALIZE_HOOKS += PETITBOOT_SYSV_INITTAB
else ifeq ($(BR2_INIT_OPENRC),y)
PETITBOOT_KEXEC_COMMAND = /sbin/openrc-shutdown --kexec now
else ifeq ($(BR2_INIT_SYSTEMD),y)
PETITBOOT_KEXEC_COMMAND = /usr/bin/systemctl kexec
else # BR2_INIT_NONE
PETITBOOT_KEXEC_COMMAND = /usr/sbin/kexec -f -e
endif

PETITBOOT_GETTY_PORT = $(patsubst %,'%',$(call qstrip,$(BR2_PACKAGE_PETITBOOT_GETTY_PORT)))

define PETITBOOT_POST_INSTALL
	$(INSTALL) -D -m 0755 $(PETITBOOT_PKGDIR)/kexec-restart.in \
		$(TARGET_DIR)/usr/libexec/petitboot/kexec-restart
	$(SED) 's~@KEXEC_COMMAND@~$(PETITBOOT_KEXEC_COMMAND)~' \
		$(TARGET_DIR)/usr/libexec/petitboot/kexec-restart
	$(INSTALL) -D -m 0755 $(@D)/utils/hooks/01-create-default-dtb \
		$(TARGET_DIR)/etc/petitboot/boot.d/01-create-default-dtb
	$(INSTALL) -D -m 0755 $(@D)/utils/hooks/90-sort-dtb \
		$(TARGET_DIR)/etc/petitboot/boot.d/90-sort-dtb
	$(INSTALL) -D -m 0755 $(PETITBOOT_PKGDIR)/S15pb-discover \
		$(TARGET_DIR)/etc/init.d/S15pb-discover
	$(INSTALL) -D -m 0755 $(PETITBOOT_PKGDIR)/pb-console \
		$(TARGET_DIR)/etc/init.d/pb-console
	$(INSTALL) -D -m 0755 $(PETITBOOT_PKGDIR)/pb-shell \
		$(TARGET_DIR)/usr/libexec/petitboot/pb-shell
	$(INSTALL) -D -m 0755 $(PETITBOOT_PKGDIR)/shell_profile \
		$(TARGET_DIR)/home/petituser/.profile

	mkdir -p $(TARGET_DIR)/etc/udev/rules.d
	for port in $(PETITBOOT_GETTY_PORT); do \
		printf 'SUBSYSTEM=="tty", KERNEL=="%s", RUN+="/etc/init.d/pb-console start $$name"\n' "$$port"; \
	done > $(TARGET_DIR)/etc/udev/rules.d/petitboot-console-ui.rules

	mkdir -p $(TARGET_DIR)/usr/share/udhcpc/default.script.d/
	ln -sf /usr/sbin/pb-udhcpc \
		$(TARGET_DIR)/usr/share/udhcpc/default.script.d/

endef

PETITBOOT_POST_INSTALL_TARGET_HOOKS += PETITBOOT_POST_INSTALL

define PETITBOOT_USERS
	petituser -1 petitgroup -1 * /home/petituser /bin/sh - petitboot user
endef

$(eval $(autotools-package))
