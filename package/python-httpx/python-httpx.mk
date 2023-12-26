################################################################################
#
# python-httpx
#
################################################################################

PYTHON_HTTPX_VERSION = 0.25.2
PYTHON_HTTPX_SOURCE = httpx-$(PYTHON_HTTPX_VERSION).tar.gz
PYTHON_HTTPX_SITE = https://files.pythonhosted.org/packages/8c/23/911d93a022979d3ea295f659fbe7edb07b3f4561a477e83b3a6d0e0c914e
PYTHON_HTTPX_SETUP_TYPE = pep517
PYTHON_HTTPX_LICENSE = BSD-3-Clause
PYTHON_HTTPX_LICENSE_FILES = LICENSE.md
PYTHON_HTTPX_CPE_ID_VENDOR = encode
PYTHON_HTTPX_CPE_ID_PRODUCT = httpx
PYTHON_HTTPX_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
