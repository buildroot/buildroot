################################################################################
#
# easydbus
#
################################################################################

EASYDBUS_VERSION = 0.2.1
EASYDBUS_SITE = $(call github,mniestroj,easydbus,v$(EASYDBUS_VERSION))
EASYDBUS_DEPENDENCIES = luainterpreter libglib2
EASYDBUS_LICENSE = MIT
EASYDBUS_LICENSE_FILES = LICENSE

$(eval $(cmake-package))
