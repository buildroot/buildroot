################################################################################
#
# python-cbor2
#
################################################################################

PYTHON_CBOR2_VERSION = 5.7.1
PYTHON_CBOR2_SOURCE = cbor2-$(PYTHON_CBOR2_VERSION).tar.gz
PYTHON_CBOR2_SITE = https://files.pythonhosted.org/packages/a2/b8/c0f6a7d46f816cb18b1fda61a2fe648abe16039f1ff93ea720a6e9fb3cee
PYTHON_CBOR2_SETUP_TYPE = setuptools
PYTHON_CBOR2_LICENSE = MIT
PYTHON_CBOR2_LICENSE_FILES = LICENSE.txt
PYTHON_CBOR2_DEPENDENCIES = host-python-setuptools-scm
PYTHON_CBOR2_ENV = CBOR2_BUILD_C_EXTENSION=1
HOST_PYTHON_CBOR2_DEPENDENCIES = host-python-setuptools-scm
HOST_PYTHON_CBOR2_ENV = CBOR2_BUILD_C_EXTENSION=0

$(eval $(python-package))
$(eval $(host-python-package))
