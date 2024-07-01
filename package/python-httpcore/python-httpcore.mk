################################################################################
#
# python-httpcore
#
################################################################################

PYTHON_HTTPCORE_VERSION = 1.0.5
PYTHON_HTTPCORE_SOURCE = httpcore-$(PYTHON_HTTPCORE_VERSION).tar.gz
PYTHON_HTTPCORE_SITE = https://files.pythonhosted.org/packages/17/b0/5e8b8674f8d203335a62fdfcfa0d11ebe09e23613c3391033cbba35f7926
PYTHON_HTTPCORE_SETUP_TYPE = pep517
PYTHON_HTTPCORE_LICENSE = BSD-3-Clause
PYTHON_HTTPCORE_LICENSE_FILES = LICENSE.md
PYTHON_HTTPCORE_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
