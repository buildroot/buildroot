################################################################################
#
# libusrsctp
#
################################################################################

LIBUSRSCTP_VERSION = d6c555f1df8f206bebbdbff75912fd88f346f8aa
LIBUSRSCTP_SITE = $(call github,sctplab,usrsctp,$(LIBUSRSCTP_VERSION))
LIBUSRSCTP_LICENSE = New BSD License

LIBUSRSCTP_INSTALL_STAGING = YES
LIBUSRSCTP_AUTORECONF = YES

LIBUSRSCTP_CONF_OPTS += \
	--disable-warnings-as-errors \
	--disable-tests \
	--disable-gtk-doc

define LIBUSRSCTP_PRE_CONFIGURE_FIXUP
	mkdir -p $(@D)/m4
	touch $(@D)/AUTHORS
	touch $(@D)/ChangeLog
	touch $(@D)/NEWS
	touch $(@D)/README
endef

LIBUSRSCTP_PRE_CONFIGURE_HOOKS += LIBUSRSCTP_PRE_CONFIGURE_FIXUP

$(eval $(autotools-package))
