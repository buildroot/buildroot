################################################################################
#
# jwt-cpp
#
################################################################################

JWT_CPP_VERSION = 0.7.2
JWT_CPP_SITE = https://github.com/Thalhammer/jwt-cpp/releases/download/v$(JWT_CPP_VERSION)
JWT_CPP_SOURCE = jwt-cpp-v$(JWT_CPP_VERSION).tar.gz
JWT_CPP_LICENSE = MIT
JWT_CPP_LICENSE_FILES = LICENSE
JWT_CPP_INSTALL_STAGING = YES
JWT_CPP_DEPENDENCIES = openssl
JWT_CPP_CONF_OPTS = \
	-DJWT_BUILD_EXAMPLES=OFF \
	-DJWT_BUILD_TESTS=OFF

$(eval $(cmake-package))
