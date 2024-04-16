################################################################################
#
# python-httpx
#
################################################################################

PYTHON_HTTPX_VERSION = 0.26.0
PYTHON_HTTPX_SOURCE = httpx-$(PYTHON_HTTPX_VERSION).tar.gz
PYTHON_HTTPX_SITE = https://files.pythonhosted.org/packages/bd/26/2dc654950920f499bd062a211071925533f821ccdca04fa0c2fd914d5d06
PYTHON_HTTPX_SETUP_TYPE = pep517
PYTHON_HTTPX_LICENSE = BSD-3-Clause
PYTHON_HTTPX_LICENSE_FILES = LICENSE.md
PYTHON_HTTPX_CPE_ID_VENDOR = encode
PYTHON_HTTPX_CPE_ID_PRODUCT = httpx
PYTHON_HTTPX_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
