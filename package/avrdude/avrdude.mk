################################################################################
#
# avrdude
#
################################################################################

AVRDUDE_VERSION = 6.4
AVRDUDE_SITE = $(call github,avrdudes,avrdude,v$(AVRDUDE_VERSION))
AVRDUDE_LICENSE = GPL-2.0+
AVRDUDE_LICENSE_FILES = COPYING

# Sources coming from git, without generated configure and Makefile.in
# files.
AVRDUDE_AUTORECONF = YES
AVRDUDE_CONF_OPTS = --enable-linuxgpio
AVRDUDE_DEPENDENCIES = elfutils libusb libusb-compat ncurses \
	host-flex host-bison

ifeq ($(BR2_PACKAGE_AVRDUDE_SPI),y)
AVRDUDE_CONF_OPTS += --enable-linuxspi
else
AVRDUDE_CONF_OPTS += --disable-linuxspi
endif

ifeq ($(BR2_PACKAGE_LIBFTDI1),y)
AVRDUDE_DEPENDENCIES += libftdi1
else ifeq ($(BR2_PACKAGE_LIBFTDI),y)
AVRDUDE_DEPENDENCIES += libftdi
endif

ifeq ($(BR2_PACKAGE_HIDAPI),y)
AVRDUDE_DEPENDENCIES += hidapi
endif

# if /etc/avrdude.conf exists, the installation process creates a
# backup file, which we do not want in the context of Buildroot.
define AVRDUDE_REMOVE_BACKUP_FILE
	$(RM) -f $(TARGET_DIR)/etc/avrdude.conf.bak
endef

AVRDUDE_POST_INSTALL_TARGET_HOOKS += AVRDUDE_REMOVE_BACKUP_FILE

$(eval $(autotools-package))
