################################################################################
#
# luasocket
#
################################################################################

LUASOCKET_VERSION = 3.0.0-1
LUASOCKET_SUBDIR = luasocket
LUASOCKET_LICENSE = MIT
LUASOCKET_LICENSE_FILES = $(LUASOCKET_SUBDIR)/LICENSE

$(eval $(luarocks-package))
