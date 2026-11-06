################################################################################
#
# python-ujson
#
################################################################################

PYTHON_UJSON_VERSION = 6.1.0
PYTHON_UJSON_SOURCE = ujson-$(PYTHON_UJSON_VERSION).tar.gz
PYTHON_UJSON_SITE = https://files.pythonhosted.org/packages/e0/60/ad782f70ce03d12ec23288292a17549ca537f9d188227340ac0d082421b3
PYTHON_UJSON_SETUP_TYPE = setuptools
PYTHON_UJSON_LICENSE = BSD-3-Clause, TCL
PYTHON_UJSON_LICENSE_FILES = LICENSE.txt
PYTHON_UJSON_DEPENDENCIES = host-python-setuptools-scm double-conversion
PYTHON_UJSON_ENV = \
	UJSON_BUILD_DC_INCLUDES="$(STAGING_DIR)/usr/include/double-conversion" \
	UJSON_BUILD_DC_LIBS="-ldouble-conversion" \
	UJSON_BUILD_NO_STRIP=1

$(eval $(python-package))
