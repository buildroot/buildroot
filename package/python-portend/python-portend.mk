################################################################################
#
# python-portend
#
################################################################################

PYTHON_PORTEND_VERSION = 3.2.0
PYTHON_PORTEND_SOURCE = portend-$(PYTHON_PORTEND_VERSION).tar.gz
PYTHON_PORTEND_SITE = https://files.pythonhosted.org/packages/8f/fc/bcfc768996b438d6e4bde7a6c8cfd62089847b0f5381a0e0ec2d8ee6b202
PYTHON_PORTEND_LICENSE = MIT
PYTHON_PORTEND_LICENSE_FILES = LICENSE
PYTHON_PORTEND_SETUP_TYPE = setuptools
PYTHON_PORTEND_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
