################################################################################
#
# lua-lrexlib-pcre2
#
################################################################################

LUA_LREXLIB_PCRE2_VERSION = 2.9.2-1
LUA_LREXLIB_PCRE2_NAME_UPSTREAM = Lrexlib-PCRE2
LUA_LREXLIB_PCRE2_SUBDIR = lrexlib
LUA_LREXLIB_PCRE2_LICENSE = MIT
LUA_LREXLIB_PCRE2_LICENSE_FILES = $(LUA_LREXLIB_PCRE2_SUBDIR)/LICENSE
LUA_LREXLIB_PCRE2_DEPENDENCIES = pcre2

$(eval $(luarocks-package))
