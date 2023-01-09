################################################################################
#
# python-attrs
#
################################################################################

PYTHON_ATTRS_VERSION = 22.2.0
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VERSION).tar.gz
PYTHON_ATTRS_SITE = https://files.pythonhosted.org/packages/21/31/3f468da74c7de4fcf9b25591e682856389b3400b4b62f201e65f15ea3e07
PYTHON_ATTRS_SETUP_TYPE = setuptools
PYTHON_ATTRS_LICENSE = MIT
PYTHON_ATTRS_LICENSE_FILES = LICENSE

$(eval $(python-package))
