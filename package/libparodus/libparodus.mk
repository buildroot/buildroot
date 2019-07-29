################################################################################
#
# libparodus
#
################################################################################

LIBPARODUS_VERSION = b603a942f5c0b22446d8ae1abb845821e24eb956
LIBPARODUS_SITE_METHOD = git
LIBPARODUS_SITE = git://github.com/Comcast/libparodus.git
LIBPARODUS_INSTALL_STAGING = YES
LIBPARODUS_DEPENDENCIES = nopoll cimplog nanomsg msgpack-c cjson trower-base64 wrp-c wdmp-c

LIBPARODUS_CONF_OPTS = -DMAIN_PROJ_BUILD=ON -DBUILD_BR=ON

$(eval $(cmake-package))
