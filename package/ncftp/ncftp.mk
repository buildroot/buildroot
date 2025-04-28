################################################################################
#
# ncftp
#
################################################################################

NCFTP_VERSION = 3.3.0
NCFTP_SOURCE = ncftp-$(NCFTP_VERSION)-src.tar.gz
NCFTP_SITE = https://www.ncftp.com/public_ftp/ncftp
NCFTP_TARGET_BINS = ncftp
NCFTP_LICENSE = ClArtistic
NCFTP_LICENSE_FILES = doc/LICENSE.txt

NCFTP_DEPENDENCIES = host-autoconf
NCFTP_CONF_OPTS = --disable-ccdv

ifeq ($(BR2_PACKAGE_NCFTP_GET),y)
NCFTP_TARGET_BINS += ncftpget
endif

ifeq ($(BR2_PACKAGE_NCFTP_PUT),y)
NCFTP_TARGET_BINS += ncftpput
endif

ifeq ($(BR2_PACKAGE_NCFTP_LS),y)
NCFTP_TARGET_BINS += ncftpls
endif

ifeq ($(BR2_PACKAGE_NCFTP_BATCH),y)
NCFTP_TARGET_BINS += ncftpbatch
NCFTP_INSTALL_NCFTP_BATCH = \
	ln -sf /usr/bin/ncftpbatch $(TARGET_DIR)/usr/bin/ncftpspooler
endif

ifeq ($(BR2_PACKAGE_NCFTP_BOOKMARKS),y)
NCFTP_TARGET_BINS += ncftpbookmarks
NCFTP_DEPENDENCIES += ncurses
endif

define NCFTP_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(addprefix $(NCFTP_DIR)/bin/, $(NCFTP_TARGET_BINS)) $(TARGET_DIR)/usr/bin
	$(NCFTP_INSTALL_NCFTP_BATCH)
endef

$(eval $(autotools-package))
