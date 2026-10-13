################################################################################
#
# python-orjson
#
################################################################################

PYTHON_ORJSON_VERSION = 3.13.0
PYTHON_ORJSON_SOURCE_PYPI = orjson-$(PYTHON_ORJSON_VERSION).tar.gz
PYTHON_ORJSON_SITE_PYPI = https://files.pythonhosted.org/packages/f2/72/380b97dc45bd162d23afe5194721ef678d9eac7cfaa549fe2873f7f0a518
PYTHON_ORJSON_SITE = $(PYTHON_ORJSON_SITE_PYPI)/$(PYTHON_ORJSON_SOURCE_PYPI)?buildroot-path=filename
PYTHON_ORJSON_SETUP_TYPE = maturin
PYTHON_ORJSON_LICENSE = Apache-2.0 or MIT, MPL-2.0
PYTHON_ORJSON_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT LICENSE-MPL-2.0

$(eval $(python-package))
