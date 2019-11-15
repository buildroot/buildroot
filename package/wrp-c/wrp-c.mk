################################################################################
#
# wrp-c
#
################################################################################

WRP_C_VERSION = 421447302e647930f7dce80f75f8946275086979
WRP_C_VERSION = 964093ce0964c787ef8b9f4e23765a9f0d70f45a
WRP_C_SITE_METHOD = git
WRP_C_SITE = git://github.com/Comcast/wrp-c.git
WRP_C_INSTALL_STAGING = YES

$(eval $(cmake-package))
