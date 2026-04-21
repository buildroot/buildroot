################################################################################
#
# python-deprecation
#
################################################################################

PYTHON_DEPRECATION_VERSION = 2.1.0
PYTHON_DEPRECATION_SOURCE = deprecation-$(PYTHON_DEPRECATION_VERSION).tar.gz
PYTHON_DEPRECATION_SITE = https://files.pythonhosted.org/packages/source/d/deprecation
PYTHON_DEPRECATION_SETUP_TYPE = setuptools
PYTHON_DEPRECATION_LICENSE = Apache-2.0
PYTHON_DEPRECATION_LICENSE_FILES = LICENSE

$(eval $(python-package))
