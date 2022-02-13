################################################################################
#
# lilv
#
################################################################################

LILV_VERSION = 0.24.12
LILV_SITE = https://download.drobilla.net
LILV_SOURCE = lilv-$(LILV_VERSION).tar.bz2
LILV_LICENSE = ISC
LILV_LICENSE_FILES = COPYING
LILV_DEPENDENCIES = host-pkgconf lv2 serd sord sratom
LILV_INSTALL_STAGING = YES

LILV_CONF_OPTS += \
	--dyn-manifest \
	--no-bash-completion \
	--no-coverage

ifeq ($(BR2_PACKAGE_PYTHON3),y)
LILV_DEPENDENCIES += python3
else
LILV_CONF_OPTS += --no-bindings
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
LILV_DEPENDENCIES += libsndfile
endif

$(eval $(waf-package))
