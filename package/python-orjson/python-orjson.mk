################################################################################
#
# python-orjson
#
################################################################################

PYTHON_ORJSON_VERSION = 3.9.10
PYTHON_ORJSON_SOURCE = orjson-$(PYTHON_ORJSON_VERSION).tar.gz
PYTHON_ORJSON_SITE = https://files.pythonhosted.org/packages/72/75/642688bf5d99131fe8cf603f4ef9f26e4b1c6ed8f7f5c7e6fb31def54fb7
PYTHON_ORJSON_SETUP_TYPE = maturin
PYTHON_ORJSON_LICENSE = Apache-2.0 or MIT
PYTHON_ORJSON_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_ORJSON_DEPENDENCIES = host-python-cffi

$(eval $(python-package))
