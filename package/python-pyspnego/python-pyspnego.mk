################################################################################
#
# python-pyspnego
#
################################################################################

PYTHON_PYSPNEGO_VERSION = 0.11.1
PYTHON_PYSPNEGO_SOURCE = pyspnego-$(PYTHON_PYSPNEGO_VERSION).tar.gz
PYTHON_PYSPNEGO_SITE = https://files.pythonhosted.org/packages/46/f5/1f938a781742d18475ac43a101ec8a9499e1655da0984e08b59e20012c04
PYTHON_PYSPNEGO_SETUP_TYPE = setuptools
PYTHON_PYSPNEGO_LICENSE = MIT
PYTHON_PYSPNEGO_LICENSE_FILES = LICENSE

$(eval $(python-package))
