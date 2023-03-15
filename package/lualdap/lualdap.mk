################################################################################
#
# lualdap
#
################################################################################

LUALDAP_VERSION = 1.3.1-1
LUALDAP_SUBDIR = lualdap
LUALDAP_LICENSE = MIT
LUALDAP_LICENSE_FILES = $(LUALDAP_SUBDIR)/docs/license.md
LUALDAP_DEPENDENCIES = openldap

$(eval $(luarocks-package))
