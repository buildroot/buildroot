################################################################################
#
# python-path
#
################################################################################

PYTHON_PATH_VERSION = 17.1.1
PYTHON_PATH_SOURCE = path-$(PYTHON_PATH_VERSION).tar.gz
PYTHON_PATH_SITE = https://files.pythonhosted.org/packages/dd/52/a7bdd5ef8488977d354b7915d1e75009bebbd04f73eff14e52372d5e9435
PYTHON_PATH_SETUP_TYPE = setuptools
PYTHON_PATH_LICENSE = MIT
PYTHON_PATH_LICENSE_FILES = LICENSE
PYTHON_PATH_DEPENDENCIES = \
	host-python-coherent-licensed \
	host-python-setuptools-scm

$(eval $(python-package))
