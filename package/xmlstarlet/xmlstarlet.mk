################################################################################
#
# xmlstarlet
#
################################################################################

XMLSTARLET_VERSION = 1.7.0
XMLSTARLET_SITE = https://github.com/xmlstarlet/xmlstarlet/releases/download/$(XMLSTARLET_VERSION)
XMLSTARLET_LICENSE = MIT
XMLSTARLET_LICENSE_FILES = COPYING

XMLSTARLET_DEPENDENCIES += host-pkgconf libxml2 libxslt \
	$(if $(BR2_PACKAGE_LIBICONV),libiconv)

ifeq ($(BR2_STATIC_LIBS),y)
XMLSTARLET_CONF_OPTS += \
	--enable-static-libs \
	--with-libxml-prefix=$(STAGING_DIR)/usr \
	--with-libxslt-prefix=$(STAGING_DIR)/usr \
	--with-libiconv-prefix=$(STAGING_DIR)/usr
else
XMLSTARLET_CONF_OPTS += --disable-static-libs
endif

HOST_XMLSTARLET_DEPENDENCIES += host-libxml2 host-libxslt host-pkgconf

$(eval $(autotools-package))
$(eval $(host-autotools-package))
