################################################################################
#
# ccspcr
#
################################################################################

CCSPCR_VERSION = 7054041df8817aa0e019a41363520ffeff9dcf91
CCSPCR_SITE_METHOD = git
CCSPCR_SITE = https://code.rdkcentral.com/r/rdkb/components/opensource/ccsp/CcspCr
CCSPCR_AUTORECONF = YES
CCSPCR_DEPENDENCIES = ccspcommonlibrary dbus telemetry rbus libxml2 libunpriv

define CCSPCR_FIXUP_M4_DIR
        mkdir $(@D)/m4
endef
CCSPCR_POST_EXTRACT_HOOKS += CCSPCR_FIXUP_M4_DIR

CCSPCR_CONF_OPTS = \
    --prefix=/usr/ \
    --includedir=$(STAGING_DIR)/usr/include \
    --libdir=$(STAGING_DIR)/usr/lib \
    --bindir=$(STAGING_DIR)/usr/bin \
    --docdir=$(STAGING_DIR)/usr/share/doc \
    --with-ccsp-platform=bcm \
    --with-ccsp-arch=arm \
    --with-rbus-build=only \
    $(CUSTOM_HOST)

CCSPCR_CPPFLAGS = $(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/dbus-1.0 -I$(STAGING_DIR)/usr/lib/dbus-1.0/include -I$(STAGING_DIR)/usr/include/ccsp -I$(STAGING_DIR)/usr/include/libxml2 -I$(STAGING_DIR)/usr/include/telemetry -I$(STAGING_DIR)/usr/include/rbus -D_DEBUG

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
CCSPCR_CPPFLAGS += -D_ANSC_LINUX
endif
CCSPCR_CPPFLAGS += -DDISABLE_RDK_LOGGER
CCSPCR_CONF_ENV += CPPFLAGS="$(CCSPCR_CPPFLAGS) `pkg-config --libs dbus-1`"

define CCSPCR_INSTALL_TARGET_CMDS
    cp -ar $(@D)/source/CcspCrSsp $(TARGET_DIR)/usr/bin
endef

define CCSPCR_INSTALL_INIT_SYSV
    $(INSTALL) -m 0755 -D $(CCSPCR_PKGDIR)/S35ccspcr \
        $(TARGET_DIR)/etc/init.d/S35ccspr
endef

$(eval $(autotools-package))
