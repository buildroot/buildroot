################################################################################
#
# python-greenlet
#
################################################################################

PYTHON_GREENLET_VERSION = 3.1.0
PYTHON_GREENLET_SOURCE = greenlet-$(PYTHON_GREENLET_VERSION).tar.gz
PYTHON_GREENLET_SITE = https://files.pythonhosted.org/packages/65/1b/3d91623c3eff61c11799e7f3d6c01f6bfa9bd2d1f0181116fd0b9b108a40
PYTHON_GREENLET_SETUP_TYPE = setuptools
PYTHON_GREENLET_LICENSE = MIT, PSF-2.0
PYTHON_GREENLET_LICENSE_FILES = LICENSE LICENSE.PSF
PYTHON_GREENLET_ENV = GREENLET_TEST_CPP=no

$(eval $(python-package))
$(eval $(host-python-package))
