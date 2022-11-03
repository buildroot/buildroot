################################################################################
#
# python-portend
#
################################################################################

PYTHON_PORTEND_VERSION = 3.1.0
PYTHON_PORTEND_SOURCE = portend-$(PYTHON_PORTEND_VERSION).tar.gz
PYTHON_PORTEND_SITE = https://files.pythonhosted.org/packages/6e/0a/42bcc9c97744958ce72d33f526e972379b9e90adede8a151f338818c41d4
PYTHON_PORTEND_LICENSE = MIT
PYTHON_PORTEND_LICENSE_FILES = LICENSE
PYTHON_PORTEND_SETUP_TYPE = setuptools
PYTHON_PORTEND_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
