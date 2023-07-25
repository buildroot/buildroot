################################################################################
#
# python-pyyaml
#
################################################################################

PYTHON_PYYAML_VERSION = 6.0.1
PYTHON_PYYAML_SOURCE = PyYAML-$(PYTHON_PYYAML_VERSION).tar.gz
PYTHON_PYYAML_SITE = https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0
PYTHON_PYYAML_SETUP_TYPE = setuptools
PYTHON_PYYAML_LICENSE = MIT
PYTHON_PYYAML_LICENSE_FILES = LICENSE
PYTHON_PYYAML_CPE_ID_VENDOR = pyyaml
PYTHON_PYYAML_CPE_ID_PRODUCT = pyyaml
PYTHON_PYYAML_DEPENDENCIES = host-python-cython libyaml
PYTHON_PYYAML_ENV = PYYAML_FORCE_CYTHON=1
HOST_PYTHON_PYYAML_DEPENDENCIES = host-libyaml

$(eval $(python-package))
$(eval $(host-python-package))
