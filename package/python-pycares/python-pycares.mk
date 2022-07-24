################################################################################
#
# python-pycares
#
################################################################################

PYTHON_PYCARES_VERSION = 4.2.1
PYTHON_PYCARES_SOURCE = pycares-$(PYTHON_PYCARES_VERSION).tar.gz
PYTHON_PYCARES_SITE = https://files.pythonhosted.org/packages/99/da/d3d20bc7bd5baadeea04ee84db16f1f07557138c313bd6200e1cffab5bee
PYTHON_PYCARES_SETUP_TYPE = setuptools
PYTHON_PYCARES_LICENSE = MIT
PYTHON_PYCARES_LICENSE_FILES = LICENSE
PYTHON_PYCARES_DEPENDENCIES = host-python-cffi

$(eval $(python-package))
