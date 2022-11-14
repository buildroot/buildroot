################################################################################
#
# python-ujson
#
################################################################################

PYTHON_UJSON_VERSION = 5.5.0
PYTHON_UJSON_SOURCE = ujson-$(PYTHON_UJSON_VERSION).tar.gz
PYTHON_UJSON_SITE = https://files.pythonhosted.org/packages/6e/4a/03ddad85a10dd52e209993a14afa0cb0dc5c348e4647329f1c53856ad9e6
PYTHON_UJSON_SETUP_TYPE = setuptools
PYTHON_UJSON_LICENSE = BSD-3-Clause
PYTHON_UJSON_LICENSE_FILES = LICENSE.txt
PYTHON_UJSON_DEPENDENCIES = host-python-setuptools-scm double-conversion
PYTHON_UJSON_ENV = \
	UJSON_BUILD_DC_INCLUDES="$(STAGING_DIR)/usr/include/double-conversion" \
	UJSON_BUILD_DC_LIBS="-ldouble-conversion" \
	UJSON_BUILD_NO_STRIP=1

$(eval $(python-package))
