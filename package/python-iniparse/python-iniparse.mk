################################################################################
#
# python-iniparse
#
################################################################################

PYTHON_INIPARSE_VERSION = 0.5.3
PYTHON_INIPARSE_SOURCE = iniparse-$(PYTHON_INIPARSE_VERSION).tar.gz
PYTHON_INIPARSE_SITE = https://files.pythonhosted.org/packages/95/2f/d7637e3cbbeb7ca2fddaf0c5986284d5a086c437139523f4bcea95a9f1d0
PYTHON_INIPARSE_LICENSE = Python-2.0, MIT
PYTHON_INIPARSE_LICENSE_FILES = LICENSE-PSF LICENSE
PYTHON_INIPARSE_SETUP_TYPE = setuptools
# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_PYTHON_INIPARSE_DEPENDENCIES = host-python-six

$(eval $(python-package))
$(eval $(host-python-package))
