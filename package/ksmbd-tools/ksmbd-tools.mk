################################################################################
#
# ksmbd-tools
#
################################################################################

KSMBD_TOOLS_VERSION = 3.5.2
KSMBD_TOOLS_SITE = https://github.com/cifsd-team/ksmbd-tools/releases/download/$(KSMBD_TOOLS_VERSION)
KSMBD_TOOLS_LICENSE = GPL-2.0+
KSMBD_TOOLS_LICENSE_FILES = COPYING
KSMBD_TOOLS_DEPENDENCIES = host-pkgconf libglib2 libnl

ifeq ($(BR2_PACKAGE_LIBKRB5),y)
KSMBD_TOOLS_CONF_OPTS += --enable-krb5
KSMBD_TOOLS_DEPENDENCIES += libkrb5
else
KSMBD_TOOLS_CONF_OPTS += --disable-krb5
endif

$(eval $(autotools-package))
