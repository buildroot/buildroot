################################################################################
#
# python-engineio
#
################################################################################

PYTHON_ENGINEIO_VERSION = 4.11.2
PYTHON_ENGINEIO_SOURCE = python_engineio-$(PYTHON_ENGINEIO_VERSION).tar.gz
PYTHON_ENGINEIO_SITE = https://files.pythonhosted.org/packages/52/e0/a9e0fe427ce7f1b7dbf9531fa00ffe4b557c4a7bc8e71891c115af123170
PYTHON_ENGINEIO_SETUP_TYPE = setuptools
PYTHON_ENGINEIO_LICENSE = MIT
PYTHON_ENGINEIO_LICENSE_FILES = LICENSE
PYTHON_ENGINEIO_CPE_ID_VALID = YES

$(eval $(python-package))
