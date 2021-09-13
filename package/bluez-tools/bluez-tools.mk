################################################################################
#
# bluez-tools
#
################################################################################

BLUEZ_TOOLS_VERSION = f65321736475429316f07ee94ec0deac8e46ec4a
BLUEZ_TOOLS_SITE = $(call github,khvzak,bluez-tools,$(BLUEZ_TOOLS_VERSION))

# sources fetched from github, no configure script)
BLUEZ_TOOLS_AUTORECONF = YES
BLUEZ_TOOLS_DEPENDENCIES = host-pkgconf dbus dbus-glib bluez5_utils readline
BLUEZ_TOOLS_LICENSE = GPL-2.0+
BLUEZ_TOOLS_LICENSE_FILES = COPYING

$(eval $(autotools-package))
