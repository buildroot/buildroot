DDCUTIL_VERSION = 1.4.1-release
DDCUTIL_SITE = $(call github,rockowitz,ddcutil,$(DDCUTIL_VERSION))
DDCUTIL_DEPENDENCIES = host-pkgconf host-autoconf host-automake host-libtool libglib2 jansson util-linux eudev 
HOST_DDCUTIL_DEPENDENCIES = host-util-linux
DDCUTIL_CONF_OPTS = --disable-usb --disable-x11
DDCUTIL_AUTORECONF = YES
DDCUTIL_TOOLCHAIN_BUILDROOT_GLIBC=y

define DDCUTIL_AUTORECONF_CMDS
	$(info Running autoreconf...)
	(cd $(@D); autoreconf -i -f -v)
endef

$(eval $(autotools-package))



