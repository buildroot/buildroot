################################################################################
#
# azmq
#
################################################################################

AZMQ_VERSION = v1.0.3-54-g819b24035cfa5b73081e21f5867445f2344f680d
AZMQ_SITE = $(call github,zeromq,azmq,$(AZMQ_VERSION))
AZMQ_DEPENDENCIES = boost zeromq
AZMQ_LICENSE = BSL-1.0
AZMQ_LICENSE_FILES = LICENSE-BOOST_1_0

# AZMQ is a header only library, so it does not need to be installed on the
# target.
AZMQ_INSTALL_STAGING = YES
AZMQ_INSTALL_TARGET = NO

AZMQ_CONF_OPTS = -DAZMQ_NO_TESTS=ON

$(eval $(cmake-package))
