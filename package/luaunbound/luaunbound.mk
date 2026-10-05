################################################################################
#
# luaunbound
#
################################################################################

LUAUNBOUND_VERSION = 1.1.0-1
LUAUNBOUND_LICENSE = MIT
LUAUNBOUND_LICENSE_FILES = $(LUAUNBOUND_SUBDIR)/LICENSE
LUAUNBOUND_DEPENDENCIES = unbound

$(eval $(luarocks-package))
