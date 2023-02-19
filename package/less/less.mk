################################################################################
#
# less
#
################################################################################

LESS_VERSION = 590
LESS_SITE = http://www.greenwoodsoftware.com/less
LESS_LICENSE = GPL-3.0+
LESS_LICENSE_FILES = COPYING
LESS_CPE_ID_VENDOR = gnu
LESS_DEPENDENCIES = ncurses

# 0001-End-OSC8-hyperlink-on-invalid-embedded-escape-sequence.patch
LESS_IGNORE_CVES += CVE-2022-46663

define LESS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/less $(TARGET_DIR)/usr/bin/less
endef

$(eval $(autotools-package))
