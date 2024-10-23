################################################################################
#
# python-httpx
#
################################################################################

PYTHON_HTTPX_VERSION = 0.27.2
PYTHON_HTTPX_SOURCE = httpx-$(PYTHON_HTTPX_VERSION).tar.gz
PYTHON_HTTPX_SITE = https://files.pythonhosted.org/packages/78/82/08f8c936781f67d9e6b9eeb8a0c8b4e406136ea4c3d1f89a5db71d42e0e6
PYTHON_HTTPX_SETUP_TYPE = hatch
PYTHON_HTTPX_LICENSE = BSD-3-Clause
PYTHON_HTTPX_LICENSE_FILES = LICENSE.md
PYTHON_HTTPX_CPE_ID_VENDOR = encode
PYTHON_HTTPX_CPE_ID_PRODUCT = httpx
PYTHON_HTTPX_DEPENDENCIES = host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
