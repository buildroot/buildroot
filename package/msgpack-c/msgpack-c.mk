################################################################################
#
# msgpack-c
#
################################################################################

MSGPACK_C_VERSION = 20ef1f925b007f170ab1c257e4aa61fdd0927773
MSGPACK_C_SITE_METHOD = git
MSGPACK_C_SITE = https://github.com/msgpack/msgpack-c
MSGPACK_C_INSTALL_STAGING = YES

$(eval $(cmake-package))
