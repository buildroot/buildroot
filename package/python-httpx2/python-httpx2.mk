################################################################################
#
# python-httpx2
#
################################################################################

PYTHON_HTTPX2_VERSION = 2.13.1
PYTHON_HTTPX2_SOURCE = httpx2-$(PYTHON_HTTPX2_VERSION).tar.gz
PYTHON_HTTPX2_SITE = https://files.pythonhosted.org/packages/d5/44/474bef2a0e9d90f1715d32cb98b0738695ca17ba324095fb2497ed7fbd59
PYTHON_HTTPX2_SETUP_TYPE = hatch
PYTHON_HTTPX2_LICENSE = BSD-3-Clause
PYTHON_HTTPX2_LICENSE_FILES = LICENSE.md
PYTHON_HTTPX2_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-uv-dynamic-versioning

$(eval $(python-package))
