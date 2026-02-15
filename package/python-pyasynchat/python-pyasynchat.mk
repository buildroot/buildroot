################################################################################
#
# python-pyasynchat
#
################################################################################

PYTHON_PYASYNCHAT_VERSION = 1.0.5
PYTHON_PYASYNCHAT_SOURCE = pyasynchat-$(PYTHON_PYASYNCHAT_VERSION).tar.gz
PYTHON_PYASYNCHAT_SITE = https://files.pythonhosted.org/packages/ec/d2/b41df9021c12ca314146abcde7bdd3d9d37d44cc01559d7f13df459ee586
PYTHON_PYASYNCHAT_SETUP_TYPE = setuptools
PYTHON_PYASYNCHAT_LICENSE = PSF-2.0
PYTHON_PYASYNCHAT_LICENSE_FILES = LICENSE

$(eval $(python-package))
