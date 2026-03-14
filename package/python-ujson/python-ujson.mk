################################################################################
#
# python-ujson
#
################################################################################

PYTHON_UJSON_VERSION = 5.12.0
PYTHON_UJSON_SOURCE = ujson-$(PYTHON_UJSON_VERSION).tar.gz
PYTHON_UJSON_SITE = https://files.pythonhosted.org/packages/cb/3e/c35530c5ffc25b71c59ae0cd7b8f99df37313daa162ce1e2f7925f7c2877
PYTHON_UJSON_SETUP_TYPE = setuptools
PYTHON_UJSON_LICENSE = BSD-3-Clause, TCL
PYTHON_UJSON_LICENSE_FILES = LICENSE.txt
PYTHON_UJSON_DEPENDENCIES = host-python-setuptools-scm double-conversion
PYTHON_UJSON_ENV = \
	UJSON_BUILD_DC_INCLUDES="$(STAGING_DIR)/usr/include/double-conversion" \
	UJSON_BUILD_DC_LIBS="-ldouble-conversion" \
	UJSON_BUILD_NO_STRIP=1

$(eval $(python-package))
