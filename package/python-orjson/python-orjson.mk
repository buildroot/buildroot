################################################################################
#
# python-orjson
#
################################################################################

PYTHON_ORJSON_VERSION = 3.12.0
PYTHON_ORJSON_SOURCE_PYPI = orjson-$(PYTHON_ORJSON_VERSION).tar.gz
PYTHON_ORJSON_SITE_PYPI = https://files.pythonhosted.org/packages/0f/f3/742fb1f62b825f2c010697eaf4e828004bc2a81e7e806666989c132c7c42
PYTHON_ORJSON_SITE = $(PYTHON_ORJSON_SITE_PYPI)/$(PYTHON_ORJSON_SOURCE_PYPI)?buildroot-path=filename
PYTHON_ORJSON_SETUP_TYPE = maturin
PYTHON_ORJSON_LICENSE = Apache-2.0 or MIT, MPL-2.0
PYTHON_ORJSON_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT LICENSE-MPL-2.0

$(eval $(python-package))
