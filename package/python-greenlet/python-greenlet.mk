################################################################################
#
# python-greenlet
#
################################################################################

PYTHON_GREENLET_VERSION = 1.1.3.post0
PYTHON_GREENLET_SOURCE = greenlet-$(PYTHON_GREENLET_VERSION).tar.gz
PYTHON_GREENLET_SITE = https://files.pythonhosted.org/packages/ea/37/e54ce453b298e890f59dba3db32461579328a07d5b65e3eabf80f971c099
PYTHON_GREENLET_SETUP_TYPE = setuptools
PYTHON_GREENLET_LICENSE = MIT, PSF-2.0
PYTHON_GREENLET_LICENSE_FILES = LICENSE LICENSE.PSF
PYTHON_GREENLET_ENV = GREENLET_TEST_CPP=no

$(eval $(python-package))
$(eval $(host-python-package))
