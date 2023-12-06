################################################################################
#
# lua-conciseserialization
#
################################################################################

LUA_CONCISESERIALIZATION_VERSION_UPSTREAM = 0.2.4
LUA_CONCISESERIALIZATION_VERSION = $(LUA_CONCISESERIALIZATION_VERSION_UPSTREAM)-1
ifeq ($(BR2_PACKAGE_LUA_5_3)$(BR2_PACKAGE_LUA_5_4),y)
LUA_CONCISESERIALIZATION_NAME_UPSTREAM = lua-ConciseSerialization-lua53
else
LUA_CONCISESERIALIZATION_NAME_UPSTREAM = lua-ConciseSerialization
endif
LUA_CONCISESERIALIZATION_SUBDIR = lua-ConciseSerialization-$(LUA_CONCISESERIALIZATION_VERSION_UPSTREAM)
LUA_CONCISESERIALIZATION_LICENSE = MIT
LUA_CONCISESERIALIZATION_LICENSE_FILES = $(LUA_CONCISESERIALIZATION_SUBDIR)/COPYRIGHT

$(eval $(luarocks-package))
