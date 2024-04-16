################################################################################
#
# lpeg
#
################################################################################

LPEG_VERSION = 1.0.2-1
LPEG_LICENSE = MIT
LPEG_LICENSE_FILES = $(LPEG_SUBDIR)/lpeg.html

$(eval $(luarocks-package))
