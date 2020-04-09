################################################################################
#
# libjpeg
#
################################################################################

LIBJPEG8_VERSION = 8d
LIBJPEG8_SITE = http://www.ijg.org/files
LIBJPEG8_SOURCE = jpegsrc.v$(LIBJPEG8_VERSION).tar.gz
LIBJPEG8_LICENSE = IJG
LIBJPEG8_LICENSE_FILES = README
LIBJPEG8_INSTALL_STAGING = YES

define LIBJPEG8_REMOVE_USELESS_TOOLS
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
endef

LIBJPEG8_POST_INSTALL_TARGET_HOOKS += LIBJPEG8_REMOVE_USELESS_TOOLS

$(eval $(autotools-package))
$(eval $(host-autotools-package))
