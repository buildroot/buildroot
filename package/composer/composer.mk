################################################################################
#
# composer
#
################################################################################

COMPOSER_VERSION = 2.5.8
COMPOSER_SOURCE = composer-$(COMPOSER_VERSION).phar
# Here, we pass a dummy URL parameter in order to control the name the file
# will have once downloaded.
# Otherwise, the names will clash ifever we update the version.
BASE_SITE = https://getcomposer.org/download/$(COMPOSER_VERSION)/composer.phar
COMPOSER_SITE = $(BASE_SITE)?n=f/$(COMPOSER_SOURCE)
COMPOSER_LICENSE = MIT
COMPOSER_LICENSE_FILES = LICENSE
COMPOSER_CPE_ID_VENDOR = getcomposer

HOST_COMPOSER_DEPENDENCIES = host-php
HOST_COMPOSER_EXTRACT_DEPENDENCIES = host-php

define HOST_COMPOSER_EXTRACT_CMDS
	cp $(HOST_COMPOSER_DL_DIR)/$(COMPOSER_SOURCE) $(@D)
	cd $(@D); $(HOST_DIR)/bin/php <<< '<?php \
		$$p = new Phar("$(COMPOSER_SOURCE)"); \
		$$p->extractTo(".", "LICENSE");'
endef

define HOST_COMPOSER_INSTALL_CMDS
	mv $(@D)/$(COMPOSER_SOURCE) $(HOST_DIR)/bin/composer
	chmod +x $(HOST_DIR)/bin/composer
endef

$(eval $(host-generic-package))
