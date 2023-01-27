################################################################################
#
# oatpp
#
################################################################################

OATPP_VERSION= 1.3.0
OATPP_SOURCE= $(OATPP_VERSION).tar.gz
OATPP_SITE= https://github.com/oatpp/oatpp/archive/refs/tags
#OATPP_SITE= git://github.com/oatpp/oatpp.git
OATPP_INSTALL_STAGING= YES
OATPP_INSTALL_TARGET= NO
OATPP_MAKE=make

$(eval $(cmake-package))

