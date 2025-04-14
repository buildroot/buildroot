################################################################################
#
# python-tzlocal
#
################################################################################

PYTHON_TZLOCAL_VERSION = 5.3.1
PYTHON_TZLOCAL_SOURCE = tzlocal-$(PYTHON_TZLOCAL_VERSION).tar.gz
PYTHON_TZLOCAL_SITE = https://files.pythonhosted.org/packages/8b/2e/c14812d3d4d9cd1773c6be938f89e5735a1f11a9f184ac3639b93cef35d5
PYTHON_TZLOCAL_SETUP_TYPE = setuptools
PYTHON_TZLOCAL_LICENSE = MIT
PYTHON_TZLOCAL_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
