################################################################################
#
# cgilua
#
################################################################################

CGILUA_VERSION = 5.2.1-1
CGILUA_LICENSE = MIT
CGILUA_LICENSE_FILES = $(CGILUA_SUBDIR)/doc/us/license.html
CGILUA_CPE_ID_VENDOR = keplerproject

$(eval $(luarocks-package))
