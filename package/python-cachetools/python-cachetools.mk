################################################################################
#
# python-cachetools
#
################################################################################

PYTHON_CACHETOOLS_VERSION = 7.2.4
PYTHON_CACHETOOLS_SOURCE = cachetools-$(PYTHON_CACHETOOLS_VERSION).tar.gz
PYTHON_CACHETOOLS_SITE = https://files.pythonhosted.org/packages/3a/5d/15ea0494ebcb9062c7ca79bf026cbba380a50538ae73753fb40bdffa79e2
PYTHON_CACHETOOLS_SETUP_TYPE = setuptools
PYTHON_CACHETOOLS_LICENSE = MIT
PYTHON_CACHETOOLS_LICENSE_FILES = LICENSE
PYTHON_CACHETOOLS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
