################################################################################
#
# lua-lgdbm
#
################################################################################

LUA_LGDBM_VERSION = 20211118.52-0
LUA_LGDBM_NAME_UPSTREAM = lgdbm
LUA_LGDBM_SUBDIR = gdbm
LUA_LGDBM_LICENSE = Public Domain
LUA_LGDBM_DEPENDENCIES = gdbm

$(eval $(luarocks-package))
