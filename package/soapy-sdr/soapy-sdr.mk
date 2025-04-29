################################################################################
#
# SoapySDR
#
################################################################################

SOAPY_SDR_VERSION = 0.8.1
SOAPY_SDR_SITE = https://github.com/pothosware/SoapySDR/archive/refs/tags
SOAPY_SDR_LICENSE = BSL-1.0
SOAPY_SDR_LICENSE_FILES = LICENSE_1_0.txt

SOAPY_SDR_SUPPORTS_IN_SOURCE_BUILD = NO

SOAPY_SDR_CONF_OPTS = \
	-DENABLE_TESTS=OFF \
	-DENABLE_DOCS=OFF \
	-DENABLE_LIBRARY=ON

# For third-party modules, the SoapySDR libraries are mandatory at
# compile time.
SOAPY_SDR_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_SOAPY_SDR_APPS),y)
SOAPY_SDR_CONF_OPTS += -DENABLE_APPS=ON
else
SOAPY_SDR_CONF_OPTS += -DENABLE_APPS=OFF
endif

ifeq ($(BR2_PACKAGE_SOAPY_SDR_PYTHON),y)
SOAPY_SDR_DEPENDENCIES += python3
SOAPY_SDR_CONF_OPTS += -DENABLE_PYTHON=ON \
	-DENABLE_PYTHON3=ON \
	-DBUILD_PYTHON3=ON \
	-DUSE_PYTHON_CONFIG=ON
else
SOAPY_SDR_CONF_OPTS += -DENABLE_PYTHON=OFF \
	-DENABLE_PYTHON3=OFF \
	-DBUILD_PYTHON3=OFF \
	-DUSE_PYTHON_CONFIG=OFF
endif

$(eval $(cmake-package))
