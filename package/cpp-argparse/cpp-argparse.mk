################################################################################
#
# cpp-argparse
#
################################################################################

CPP_ARGPARSE_VERSION = 3.2
CPP_ARGPARSE_SITE = $(call github,p-ranav,argparse,v$(CPP_ARGPARSE_VERSION))
CPP_ARGPARSE_LICENSE = MIT
CPP_ARGPARSE_LICENSE_FILES = LICENSE
CPP_ARGPARSE_INSTALL_STAGING = YES
CPP_ARGPARSE_INSTALL_TARGET = NO

CPP_ARGPARSE_CONF_OPTS = -DARGPARSE_BUILD_SAMPLES=OFF -DARGPARSE_BUILD_TESTS=OFF

$(eval $(cmake-package))
