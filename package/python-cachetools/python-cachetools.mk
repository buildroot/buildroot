################################################################################
#
# python-cachetools
#
################################################################################

PYTHON_CACHETOOLS_VERSION = 7.3.0
PYTHON_CACHETOOLS_SOURCE = cachetools-$(PYTHON_CACHETOOLS_VERSION).tar.gz
PYTHON_CACHETOOLS_SITE = https://files.pythonhosted.org/packages/5f/6b/6c1553e1e8f672f9423344a1915aad1537439ad3d14a3fbc1a02159cfd94
PYTHON_CACHETOOLS_SETUP_TYPE = setuptools
PYTHON_CACHETOOLS_LICENSE = MIT
PYTHON_CACHETOOLS_LICENSE_FILES = LICENSE
PYTHON_CACHETOOLS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
