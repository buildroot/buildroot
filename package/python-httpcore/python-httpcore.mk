################################################################################
#
# python-httpcore
#
################################################################################

PYTHON_HTTPCORE_VERSION = 1.0.7
PYTHON_HTTPCORE_SOURCE = httpcore-$(PYTHON_HTTPCORE_VERSION).tar.gz
PYTHON_HTTPCORE_SITE = https://files.pythonhosted.org/packages/6a/41/d7d0a89eb493922c37d343b607bc1b5da7f5be7e383740b4753ad8943e90
PYTHON_HTTPCORE_SETUP_TYPE = hatch
PYTHON_HTTPCORE_LICENSE = BSD-3-Clause
PYTHON_HTTPCORE_LICENSE_FILES = LICENSE.md
PYTHON_HTTPCORE_DEPENDENCIES = host-python-hatch-fancy-pypi-readme

$(eval $(python-package))
