################################################################################
#
# xml-security-c
#
################################################################################

XML_SECURITY_C_VERSION = 2.0.4
XML_SECURITY_C_SITE = http://archive.apache.org/dist/santuario/c-library
XML_SECURITY_C_LICENSE = Apache-2.0
XML_SECURITY_C_LICENSE_FILES = LICENSE.txt
XML_SECURITY_C_DEPENDENCIES = openssl xerces
XML_SECURITY_C_INSTALL_STAGING = YES

XML_SECURITY_C_CONF_ENV = \
	xml_cv_func_getcwd_null=yes \
	CXXFLAGS="$(TARGET_CXXFLAGS) -std=c++11"

$(eval $(autotools-package))
