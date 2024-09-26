################################################################################
#
# python-ujson
#
################################################################################

PYTHON_UJSON_VERSION = 5.10.0
PYTHON_UJSON_SOURCE = ujson-$(PYTHON_UJSON_VERSION).tar.gz
PYTHON_UJSON_SITE = https://files.pythonhosted.org/packages/f0/00/3110fd566786bfa542adb7932d62035e0c0ef662a8ff6544b6643b3d6fd7
PYTHON_UJSON_SETUP_TYPE = setuptools
PYTHON_UJSON_LICENSE = BSD-3-Clause, TCL
PYTHON_UJSON_LICENSE_FILES = LICENSE.txt
PYTHON_UJSON_DEPENDENCIES = host-python-setuptools-scm double-conversion
PYTHON_UJSON_ENV = \
	UJSON_BUILD_DC_INCLUDES="$(STAGING_DIR)/usr/include/double-conversion" \
	UJSON_BUILD_DC_LIBS="-ldouble-conversion" \
	UJSON_BUILD_NO_STRIP=1

$(eval $(python-package))
