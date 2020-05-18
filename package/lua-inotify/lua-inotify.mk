################################################################################
#
# lua-inotify
#
################################################################################

LUA_INOTIFY_VERSION_UPSTREAM = 0.5
LUA_INOTIFY_VERSION = $(LUA_INOTIFY_VERSION_UPSTREAM)-1
LUA_INOTIFY_NAME_UPSTREAM = inotify
LUA_INOTIFY_SUBDIR = linotify-$(LUA_INOTIFY_VERSION_UPSTREAM)
LUA_INOTIFY_LICENSE = MIT
LUA_INOTIFY_LICENSE_FILES = $(LUA_INOTIFY_SUBDIR)/COPYRIGHT

$(eval $(luarocks-package))
