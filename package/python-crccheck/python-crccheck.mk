################################################################################
#
# python-crccheck
#
################################################################################

PYTHON_CRCCHECK_VERSION = 1.3.1
PYTHON_CRCCHECK_SOURCE = crccheck-$(PYTHON_CRCCHECK_VERSION).tar.gz
PYTHON_CRCCHECK_SITE = https://files.pythonhosted.org/packages/3c/d1/a943f4f1ca899917cc3fe1cb89d59348edd1b407503e4b02608e8d6b421e
PYTHON_CRCCHECK_LICENSE = MIT
PYTHON_CRCCHECK_LICENSE_FILES = LICENSE.txt
PYTHON_CRCCHECK_SETUP_TYPE = setuptools
HOST_PYTHON_CRCCHECK_DEPENDENCIES = host-python-setuptools-scm

$(eval $(host-python-package))
