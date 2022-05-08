################################################################################
#
# python-cbor2
#
################################################################################

PYTHON_CBOR2_VERSION = 5.4.3
PYTHON_CBOR2_SOURCE = cbor2-$(PYTHON_CBOR2_VERSION).tar.gz
PYTHON_CBOR2_SITE = https://files.pythonhosted.org/packages/9d/c9/cfa5c35a62642a19c14bf9a12dfbf0ee134466be1f062df2258a2ec2f2f7
PYTHON_CBOR2_SETUP_TYPE = setuptools
PYTHON_CBOR2_LICENSE = MIT
PYTHON_CBOR2_LICENSE_FILES = LICENSE.txt
PYTHON_CBOR2_DEPENDENCIES = host-python-setuptools-scm
PYTHON_CBOR2_ENV = CBOR2_BUILD_C_EXTENSION=1

$(eval $(python-package))
