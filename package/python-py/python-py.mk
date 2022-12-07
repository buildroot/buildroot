################################################################################
#
# python-py
#
################################################################################

PYTHON_PY_VERSION = 1.11.0
PYTHON_PY_SOURCE = py-$(PYTHON_PY_VERSION).tar.gz
PYTHON_PY_SITE = https://files.pythonhosted.org/packages/98/ff/fec109ceb715d2a6b4c4a85a61af3b40c723a961e8828319fbcb15b868dc
PYTHON_PY_DEPENDENCIES = host-python-setuptools-scm
PYTHON_PY_SETUP_TYPE = setuptools
PYTHON_PY_LICENSE = MIT
PYTHON_PY_LICENSE_FILES = LICENSE py/_vendored_packages/iniconfig-1.1.1.dist-info/LICENSE
PYTHON_PY_CPE_ID_VENDOR = pytest
PYTHON_PY_CPE_ID_PRODUCT = py

$(eval $(python-package))
