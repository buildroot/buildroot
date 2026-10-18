################################################################################
#
# python-httpx2
#
################################################################################

PYTHON_HTTPX2_VERSION = 2.14.0
PYTHON_HTTPX2_SOURCE = httpx2-$(PYTHON_HTTPX2_VERSION).tar.gz
PYTHON_HTTPX2_SITE = https://files.pythonhosted.org/packages/e8/67/58353f1848b4ba568e1ec22ea1e0d8e039f0bca5fde7e2d1f07739fd83e7
PYTHON_HTTPX2_SETUP_TYPE = hatch
PYTHON_HTTPX2_LICENSE = BSD-3-Clause
PYTHON_HTTPX2_LICENSE_FILES = LICENSE.md
PYTHON_HTTPX2_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-uv-dynamic-versioning

$(eval $(python-package))
