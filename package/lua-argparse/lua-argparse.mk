################################################################################
#
# lua-argparse
#
################################################################################

LUA_ARGPARSE_VERSION = 0.7.1-1
LUA_ARGPARSE_NAME_UPSTREAM = argparse
LUA_ARGPARSE_LICENSE = MIT
LUA_ARGPARSE_LICENSE_FILES = $(LUA_ARGPARSE_SUBDIR)/LICENSE

$(eval $(luarocks-package))
