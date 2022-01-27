################################################################################
#
# python-cbor2
#
################################################################################

PYTHON_CBOR2_VERSION = 5.4.2
PYTHON_CBOR2_SOURCE = cbor2-$(PYTHON_CBOR2_VERSION).tar.gz
PYTHON_CBOR2_SITE = https://files.pythonhosted.org/packages/d4/ca/b96be94f694155ce58823c38cf8fd1aa620bdc91e2c801713cdb4167b6aa
PYTHON_CBOR2_SETUP_TYPE = setuptools
PYTHON_CBOR2_LICENSE = MIT
PYTHON_CBOR2_LICENSE_FILES = LICENSE.txt
PYTHON_CBOR2_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
