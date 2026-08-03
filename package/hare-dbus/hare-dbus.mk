################################################################################
#
# hare-dbus
#
################################################################################

HARE_DBUS_VERSION = e9a89f8bc5ce783fa25f0eb67d7d8932db90bcc2
HARE_DBUS_SITE_METHOD = git
HARE_DBUS_SITE = https://git.sr.ht/~whynothugo/hare-dbus
HARE_DBUS_LICENSE = MIT
HARE_DBUS_LICENSE_FILES = LICENCE
HARE_DBUS_INSTALL_STAGING = YES
HARE_DBUS_DEPENDENCIES = hare-ev hare-xml

$(eval $(hare-package))
