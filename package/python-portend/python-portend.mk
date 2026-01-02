################################################################################
#
# python-portend
#
################################################################################

PYTHON_PORTEND_VERSION = 3.2.1
PYTHON_PORTEND_SOURCE = portend-$(PYTHON_PORTEND_VERSION).tar.gz
PYTHON_PORTEND_SITE = https://files.pythonhosted.org/packages/b7/57/be90f42996fc4f57d5742ef2c95f7f7bb8e9183af2cc11bff8e7df338888
PYTHON_PORTEND_LICENSE = MIT
PYTHON_PORTEND_LICENSE_FILES = LICENSE
PYTHON_PORTEND_SETUP_TYPE = setuptools
PYTHON_PORTEND_DEPENDENCIES = \
	host-python-coherent-licensed \
	host-python-setuptools-scm

$(eval $(python-package))
