################################################################################
#
# python-httpcore
#
################################################################################

PYTHON_HTTPCORE_VERSION = 1.0.2
PYTHON_HTTPCORE_SOURCE = httpcore-$(PYTHON_HTTPCORE_VERSION).tar.gz
PYTHON_HTTPCORE_SITE = https://files.pythonhosted.org/packages/18/56/78a38490b834fa0942cbe6d39bd8a7fd76316e8940319305a98d2b320366
PYTHON_HTTPCORE_SETUP_TYPE = pep517
PYTHON_HTTPCORE_LICENSE = BSD-3-Clause
PYTHON_HTTPCORE_LICENSE_FILES = LICENSE.md
PYTHON_HTTPCORE_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
