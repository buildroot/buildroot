################################################################################
#
# python-pyyaml
#
################################################################################

PYTHON_PYYAML_VERSION = 6.0.3
PYTHON_PYYAML_SOURCE = pyyaml-$(PYTHON_PYYAML_VERSION).tar.gz
PYTHON_PYYAML_SITE = https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2
PYTHON_PYYAML_SETUP_TYPE = setuptools
PYTHON_PYYAML_LICENSE = MIT
PYTHON_PYYAML_LICENSE_FILES = LICENSE
PYTHON_PYYAML_CPE_ID_VENDOR = pyyaml
PYTHON_PYYAML_CPE_ID_PRODUCT = pyyaml
PYTHON_PYYAML_DEPENDENCIES = host-python-cython libyaml
PYTHON_PYYAML_ENV = PYYAML_FORCE_CYTHON=1
HOST_PYTHON_PYYAML_DEPENDENCIES = host-libyaml host-python-cython
HOST_PYTHON_PYYAML_ENV = PYYAML_FORCE_CYTHON=1

$(eval $(python-package))
$(eval $(host-python-package))
