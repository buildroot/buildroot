################################################################################
#
# python-beniget
#
################################################################################

PYTHON_BENIGET_VERSION = 0.5.0
PYTHON_BENIGET_SOURCE = beniget-$(PYTHON_BENIGET_VERSION).tar.gz
PYTHON_BENIGET_SITE = https://files.pythonhosted.org/packages/31/a9/cf7c2317da1f5034fdebe84555e14a474b3297ef2d03ad148ff02fef2e3a
PYTHON_BENIGET_SETUP_TYPE = setuptools
PYTHON_BENIGET_LICENSE = BSD-3-Clause
PYTHON_BENIGET_LICENSE_FILES = LICENSE
HOST_PYTHON_BENIGET_DEPENDENCIES = host-python-gast

$(eval $(host-python-package))
