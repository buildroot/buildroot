################################################################################
#
# libparodus
#
################################################################################

LIBPARODUS_VERSION = 8263bb06c8c16dc114c800a3d29d0c8252f15619
LIBPARODUS_SITE_METHOD = git
LIBPARODUS_SITE = https://github.com/Comcast/libparodus.git
LIBPARODUS_INSTALL_STAGING = YES
LIBPARODUS_DEPENDENCIES = nopoll cimplog nanomsg msgpack-c cjson trower-base64 wrp-c wdmp-c

LIBPARODUS_CONF_OPTS = -DMAIN_PROJ_BUILD=ON -DBUILD_BR=ON -DBUILD_TESTING=OFF

$(eval $(cmake-package))
