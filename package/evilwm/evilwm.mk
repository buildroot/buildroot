################################################################################
#
# evilwm
#
################################################################################

EVILWM_VERSION = 1.4.3
EVILWM_SITE = https://www.6809.org.uk/evilwm/dl
EVILWM_LICENSE = evilwm license
EVILWM_LICENSE_FILES = README

EVILWM_DEPENDENCIES = xlib_libX11 xlib_libXrandr

define EVILWM_INSTALL_XSESSION_FILE
	$(INSTALL) -m 0755 -D package/evilwm/xsession \
		$(TARGET_DIR)/root/.xsession
endef

EVILWM_POST_INSTALL_TARGET_HOOKS += EVILWM_INSTALL_XSESSION_FILE

$(eval $(autotools-package))
