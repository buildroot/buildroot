################################################################################
#
# python-arrow
#
################################################################################

PYTHON_ARROW_VERSION = 1.2.0
PYTHON_ARROW_SOURCE = arrow-$(PYTHON_ARROW_VERSION).tar.gz
PYTHON_ARROW_SITE = https://files.pythonhosted.org/packages/dc/bd/2565b8533bb8cf66e10a9e68a1d489ad839799b2050f0635039e614e3b1a
PYTHON_ARROW_SETUP_TYPE = setuptools
PYTHON_ARROW_LICENSE = Apache-2.0
PYTHON_ARROW_LICENSE_FILES = LICENSE

$(eval $(python-package))
