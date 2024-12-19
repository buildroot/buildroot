################################################################################
#
# python-httpx
#
################################################################################

PYTHON_HTTPX_VERSION = 0.28.1
PYTHON_HTTPX_SOURCE = httpx-$(PYTHON_HTTPX_VERSION).tar.gz
PYTHON_HTTPX_SITE = https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956
PYTHON_HTTPX_SETUP_TYPE = hatch
PYTHON_HTTPX_LICENSE = BSD-3-Clause
PYTHON_HTTPX_LICENSE_FILES = LICENSE.md
PYTHON_HTTPX_CPE_ID_VENDOR = encode
PYTHON_HTTPX_CPE_ID_PRODUCT = httpx
PYTHON_HTTPX_DEPENDENCIES = host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
