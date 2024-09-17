################################################################################
#
# python-orjson
#
################################################################################

PYTHON_ORJSON_VERSION = 3.10.7
PYTHON_ORJSON_SOURCE_PYPI = orjson-$(PYTHON_ORJSON_VERSION).tar.gz
PYTHON_ORJSON_SITE_PYPI = https://files.pythonhosted.org/packages/9e/03/821c8197d0515e46ea19439f5c5d5fd9a9889f76800613cfac947b5d7845
PYTHON_ORJSON_SITE = $(PYTHON_ORJSON_SITE_PYPI)/$(PYTHON_ORJSON_SOURCE_PYPI)?buildroot-path=filename
PYTHON_ORJSON_SETUP_TYPE = maturin
PYTHON_ORJSON_LICENSE = Apache-2.0 or MIT
PYTHON_ORJSON_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_ORJSON_DEPENDENCIES = host-python-cffi

$(eval $(python-package))
