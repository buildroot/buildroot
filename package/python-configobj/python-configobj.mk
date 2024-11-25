################################################################################
#
# python-configobj
#
################################################################################

PYTHON_CONFIGOBJ_VERSION = 5.0.9
PYTHON_CONFIGOBJ_SOURCE = configobj-$(PYTHON_CONFIGOBJ_VERSION).tar.gz
PYTHON_CONFIGOBJ_SITE = https://files.pythonhosted.org/packages/f5/c4/c7f9e41bc2e5f8eeae4a08a01c91b2aea3dfab40a3e14b25e87e7db8d501
PYTHON_CONFIGOBJ_SETUP_TYPE = setuptools
PYTHON_CONFIGOBJ_LICENSE = BSD-3-Clause
PYTHON_CONFIGOBJ_LICENSE_FILES = LICENSE

$(eval $(python-package))
