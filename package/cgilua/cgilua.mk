################################################################################
#
# cgilua
#
################################################################################

CGILUA_VERSION = 6.0.2-0
CGILUA_SUBDIR = cgilua
CGILUA_LICENSE = MIT
CGILUA_LICENSE_FILES = $(CGILUA_SUBDIR)/doc/us/license.html

$(eval $(luarocks-package))
