################################################################################
#
# docopt.cpp
#
################################################################################

DOCOPT_CPP_VERSION = 0.6.3
DOCOPT_CPP_SITE = $(call github,docopt,docopt.cpp,v$(DOCOPT_CPP_VERSION))
DOCOPT_CPP_INSTALL_STAGING = YES
DOCOPT_CPP_LICENSE = BSL-1.0 or MIT
DOCOPT_CPP_LICENSE_FILES = LICENSE-Boost-1.0 LICENSE-MIT

$(eval $(cmake-package))
