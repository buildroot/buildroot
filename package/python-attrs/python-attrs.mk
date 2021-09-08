################################################################################
#
# python-attrs
#
################################################################################

PYTHON_ATTRS_VERSION = 21.2.0
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VERSION).tar.gz
PYTHON_ATTRS_SITE = https://files.pythonhosted.org/packages/ed/d6/3ebca4ca65157c12bd08a63e20ac0bdc21ac7f3694040711f9fd073c0ffb
PYTHON_ATTRS_SETUP_TYPE = setuptools
PYTHON_ATTRS_LICENSE = MIT
PYTHON_ATTRS_LICENSE_FILES = LICENSE

$(eval $(python-package))
