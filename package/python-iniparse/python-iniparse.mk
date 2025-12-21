################################################################################
#
# python-iniparse
#
################################################################################

PYTHON_INIPARSE_VERSION = 0.5
PYTHON_INIPARSE_SOURCE = iniparse-$(PYTHON_INIPARSE_VERSION).tar.gz
PYTHON_INIPARSE_SITE = https://files.pythonhosted.org/packages/4c/9a/02beaf11fc9ea7829d3a9041536934cd03990e09c359724f99ee6bd2b41b
PYTHON_INIPARSE_LICENSE = Python-2.0, MIT
PYTHON_INIPARSE_LICENSE_FILES = LICENSE-PSF LICENSE
PYTHON_INIPARSE_SETUP_TYPE = setuptools
# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_PYTHON_INIPARSE_DEPENDENCIES = host-python-six

$(eval $(python-package))
$(eval $(host-python-package))
