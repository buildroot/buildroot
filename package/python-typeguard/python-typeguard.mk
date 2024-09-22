################################################################################
#
# python-typeguard
#
################################################################################

PYTHON_TYPEGUARD_VERSION = 4.3.0
PYTHON_TYPEGUARD_SOURCE = typeguard-$(PYTHON_TYPEGUARD_VERSION).tar.gz
PYTHON_TYPEGUARD_SITE = https://files.pythonhosted.org/packages/8d/e1/3178b3e5369a98239ed7301e3946747048c66f4023163d55918f11b82d4e
PYTHON_TYPEGUARD_SETUP_TYPE = setuptools
PYTHON_TYPEGUARD_LICENSE = MIT
PYTHON_TYPEGUARD_LICENSE_FILES = LICENSE
PYTHON_TYPEGUARD_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
