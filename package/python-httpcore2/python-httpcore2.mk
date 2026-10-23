################################################################################
#
# python-httpcore2
#
################################################################################

PYTHON_HTTPCORE2_VERSION = 2.16.0
PYTHON_HTTPCORE2_SOURCE = httpcore2-$(PYTHON_HTTPCORE2_VERSION).tar.gz
PYTHON_HTTPCORE2_SITE = https://files.pythonhosted.org/packages/c0/61/afa9d6b7452f9eca73f73d45324eb0bb52f098fd5e6049bf6b8263be9b4e
PYTHON_HTTPCORE2_SETUP_TYPE = hatch
PYTHON_HTTPCORE2_LICENSE = BSD-3-Clause
PYTHON_HTTPCORE2_LICENSE_FILES = LICENSE.md
PYTHON_HTTPCORE2_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-uv-dynamic-versioning

$(eval $(python-package))
