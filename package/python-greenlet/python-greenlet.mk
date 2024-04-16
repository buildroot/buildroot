################################################################################
#
# python-greenlet
#
################################################################################

PYTHON_GREENLET_VERSION = 3.0.3
PYTHON_GREENLET_SOURCE = greenlet-$(PYTHON_GREENLET_VERSION).tar.gz
PYTHON_GREENLET_SITE = https://files.pythonhosted.org/packages/17/14/3bddb1298b9a6786539ac609ba4b7c9c0842e12aa73aaa4d8d73ec8f8185
PYTHON_GREENLET_SETUP_TYPE = setuptools
PYTHON_GREENLET_LICENSE = MIT, PSF-2.0
PYTHON_GREENLET_LICENSE_FILES = LICENSE LICENSE.PSF
PYTHON_GREENLET_ENV = GREENLET_TEST_CPP=no

$(eval $(python-package))
$(eval $(host-python-package))
