################################################################################
#
# python-pyasynchat
#
################################################################################

PYTHON_PYASYNCHAT_VERSION = 1.0.4
PYTHON_PYASYNCHAT_SOURCE = pyasynchat-$(PYTHON_PYASYNCHAT_VERSION).tar.gz
PYTHON_PYASYNCHAT_SITE = https://github.com/simonrob/pyasynchat/releases/download/v$(PYTHON_PYASYNCHAT_VERSION)
PYTHON_PYASYNCHAT_SETUP_TYPE = setuptools
PYTHON_PYASYNCHAT_LICENSE = PSF-2.0
PYTHON_PYASYNCHAT_LICENSE_FILES = LICENSE

$(eval $(python-package))
