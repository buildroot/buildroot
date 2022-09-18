################################################################################
#
# cracklib
#
################################################################################

CRACKLIB_VERSION = 2.9.8
CRACKLIB_SOURCE = cracklib-$(CRACKLIB_VERSION).tar.bz2
CRACKLIB_SITE = https://github.com/cracklib/cracklib/releases/download/v$(CRACKLIB_VERSION)
CRACKLIB_LICENSE = LGPL-2.1
CRACKLIB_LICENSE_FILES = COPYING.LIB
CRACKLIB_CPE_ID_VENDOR = cracklib_project
CRACKLIB_INSTALL_STAGING = YES
CRACKLIB_DEPENDENCIES = host-cracklib $(TARGET_NLS_DEPENDENCIES)
CRACKLIB_CONF_ENV = LIBS=$(TARGET_NLS_LIBS)

ifeq ($(BR2_PACKAGE_ZLIB),y)
CRACKLIB_CONF_OPTS += --with-zlib
CRACKLIB_DEPENDENCIES += zlib
else
CRACKLIB_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
CRACKLIB_CONF_OPTS += --with-python
CRACKLIB_CONF_ENV += \
	ac_cv_path_PYTHON=$(HOST_DIR)/bin/python3 \
	am_cv_python_version=$(PYTHON3_VERSION_MAJOR)
CRACKLIB_DEPENDENCIES += python3
else
CRACKLIB_CONF_OPTS += --without-python
endif

HOST_CRACKLIB_CONF_OPTS += --without-python --without-zlib

ifeq ($(BR2_PACKAGE_CRACKLIB_FULL_DICT),y)
CRACKLIB_EXTRA_DOWNLOADS = cracklib-words-$(CRACKLIB_VERSION).bz2
CRACKLIB_DICT_SOURCE = $(CRACKLIB_DL_DIR)/cracklib-words-$(CRACKLIB_VERSION).bz2
else
CRACKLIB_DICT_SOURCE = $(@D)/dicts/cracklib-small
endif

ifeq ($(BR2_PACKAGE_CRACKLIB_TOOLS),)
define CRACKLIB_REMOVE_TOOLS
	rm -f $(TARGET_DIR)/usr/sbin/*cracklib*
endef
CRACKLIB_POST_INSTALL_TARGET_HOOKS += CRACKLIB_REMOVE_TOOLS
endif

define CRACKLIB_BUILD_DICT
	$(HOST_MAKE_ENV) cracklib-format $(CRACKLIB_DICT_SOURCE) | \
		$(HOST_MAKE_ENV) cracklib-packer $(TARGET_DIR)/usr/share/cracklib/pw_dict
	rm $(TARGET_DIR)/usr/share/cracklib/cracklib-small
endef
CRACKLIB_POST_INSTALL_TARGET_HOOKS += CRACKLIB_BUILD_DICT

$(eval $(autotools-package))
$(eval $(host-autotools-package))
