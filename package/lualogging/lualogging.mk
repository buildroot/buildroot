################################################################################
#
# lualogging
#
################################################################################

LUALOGGING_VERSION = 1.6.0-1
LUALOGGING_SUBDIR = lualogging
LUALOGGING_LICENSE = MIT
LUALOGGING_LICENSE_FILES = $(LUALOGGING_SUBDIR)/COPYRIGHT

$(eval $(luarocks-package))
