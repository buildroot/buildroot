################################################################################
#
# python-pyyaml
#
################################################################################

PYTHON_PYYAML_VERSION = 6.0
PYTHON_PYYAML_SOURCE = PyYAML-$(PYTHON_PYYAML_VERSION).tar.gz
PYTHON_PYYAML_SITE = https://files.pythonhosted.org/packages/36/2b/61d51a2c4f25ef062ae3f74576b01638bebad5e045f747ff12643df63844
PYTHON_PYYAML_SETUP_TYPE = setuptools
PYTHON_PYYAML_LICENSE = MIT
PYTHON_PYYAML_LICENSE_FILES = LICENSE
PYTHON_PYYAML_CPE_ID_VENDOR = pyyaml
PYTHON_PYYAML_CPE_ID_PRODUCT = pyyaml
PYTHON_PYYAML_DEPENDENCIES = host-python-cython libyaml
PYTHON_PYYAML_ENV = PYYAML_FORCE_CYTHON=1
HOST_PYTHON_PYYAML_DEPENDENCIES = host-libyaml
HOST_PYTHON_PYYAML_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
$(eval $(host-python-package))
