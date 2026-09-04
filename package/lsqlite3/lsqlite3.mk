################################################################################
#
# lsqlite3
#
################################################################################

LSQLITE3_VERSION = 0.9.7-1
LSQLITE3_SUBDIR = lsqlite3_v097
LSQLITE3_LICENSE = MIT
LSQLITE3_DEPENDENCIES = sqlite

$(eval $(luarocks-package))
