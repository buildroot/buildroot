################################################################################
#
# lua-http
#
################################################################################

LUA_HTTP_VERSION_UPSTREAM = 0.4
LUA_HTTP_VERSION = $(LUA_HTTP_VERSION_UPSTREAM)-0
LUA_HTTP_NAME_UPSTREAM = http
LUA_HTTP_SUBDIR = lua-http-$(LUA_HTTP_VERSION_UPSTREAM)
LUA_HTTP_LICENSE = MIT
LUA_HTTP_LICENSE_FILES = $(LUA_HTTP_SUBDIR)/LICENSE.md
LUA_HTTP_CPE_ID_VERSION = $(LUA_HTTP_VERSION_UPSTREAM)
LUA_HTTP_CPE_ID_VENDOR = daurnimator

# 0001-http-h1_stream-handle-EOF-when-body_read_type-length.patch
LUA_HTTP_IGNORE_CVES += CVE-2023-4540

$(eval $(luarocks-package))
