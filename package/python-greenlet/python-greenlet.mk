################################################################################
#
# python-greenlet
#
################################################################################

PYTHON_GREENLET_VERSION = 2.0.1
PYTHON_GREENLET_SOURCE = greenlet-$(PYTHON_GREENLET_VERSION).tar.gz
PYTHON_GREENLET_SITE = https://files.pythonhosted.org/packages/fd/6a/f07b0028baff9bca61ecfcd9ee021e7e33369da8094f00eff409f2ff32be
PYTHON_GREENLET_SETUP_TYPE = setuptools
PYTHON_GREENLET_LICENSE = MIT, PSF-2.0
PYTHON_GREENLET_LICENSE_FILES = LICENSE LICENSE.PSF
PYTHON_GREENLET_ENV = GREENLET_TEST_CPP=no

$(eval $(python-package))
$(eval $(host-python-package))
