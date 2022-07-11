################################################################################
#
# wrp-c
#
################################################################################

WRP_C_VERSION = 38d26e8c83aae27b2b83130b68e15b919e4b5e37
WRP_C_SITE_METHOD = git
WRP_C_SITE = https://github.com/Comcast/wrp-c.git

WRP_C_CONF_OPTS = -DBUILD_TESTING=OFF
WRP_C_INSTALL_STAGING = YES

$(eval $(cmake-package))
