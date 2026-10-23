################################################################################
#
# python-httpx2
#
################################################################################

PYTHON_HTTPX2_VERSION = 2.16.0
PYTHON_HTTPX2_SOURCE = httpx2-$(PYTHON_HTTPX2_VERSION).tar.gz
PYTHON_HTTPX2_SITE = https://files.pythonhosted.org/packages/43/73/5ca2cedf5e4e50423d1c258877865a6b62793633b561c58499f8aeb33b7e
PYTHON_HTTPX2_SETUP_TYPE = hatch
PYTHON_HTTPX2_LICENSE = BSD-3-Clause
PYTHON_HTTPX2_LICENSE_FILES = LICENSE.md
PYTHON_HTTPX2_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-uv-dynamic-versioning

$(eval $(python-package))
