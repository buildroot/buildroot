################################################################################
#
# python-httpx
#
################################################################################

PYTHON_HTTPX_VERSION = 0.27.0
PYTHON_HTTPX_SOURCE = httpx-$(PYTHON_HTTPX_VERSION).tar.gz
PYTHON_HTTPX_SITE = https://files.pythonhosted.org/packages/5c/2d/3da5bdf4408b8b2800061c339f240c1802f2e82d55e50bd39c5a881f47f0
PYTHON_HTTPX_SETUP_TYPE = pep517
PYTHON_HTTPX_LICENSE = BSD-3-Clause
PYTHON_HTTPX_LICENSE_FILES = LICENSE.md
PYTHON_HTTPX_CPE_ID_VENDOR = encode
PYTHON_HTTPX_CPE_ID_PRODUCT = httpx
PYTHON_HTTPX_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
