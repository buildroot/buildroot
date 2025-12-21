################################################################################
#
# python-pyasynchat
#
################################################################################

PYTHON_PYASYNCHAT_VERSION = 1.0.4
PYTHON_PYASYNCHAT_SOURCE = pyasynchat-$(PYTHON_PYASYNCHAT_VERSION).tar.gz
PYTHON_PYASYNCHAT_SITE = https://files.pythonhosted.org/packages/8a/fd/aacc6309abcc5a388c66915829cd8175daccac583828fde40a1eea5768e4
PYTHON_PYASYNCHAT_SETUP_TYPE = setuptools
PYTHON_PYASYNCHAT_LICENSE = PSF-2.0
PYTHON_PYASYNCHAT_LICENSE_FILES = LICENSE

$(eval $(python-package))
