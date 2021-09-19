################################################################################
#
# python3-pip
#
################################################################################

# Please keep in sync with package/python-pip/python-pip.mk
PYTHON3_PIP_VERSION = 21.2.4
PYTHON3_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON3_PIP_SITE = https://files.pythonhosted.org/packages/52/e1/06c018197d8151383f66ebf6979d951995cf495629fc54149491f5d157d0
PYTHON3_PIP_SETUP_TYPE = setuptools
PYTHON3_PIP_LICENSE = MIT
PYTHON3_PIP_LICENSE_FILES = LICENSE.txt
PYTHON3_PIP_CPE_ID_VENDOR = pypa
PYTHON3_PIP_CPE_ID_PRODUCT = pip
HOST_PYTHON3_PIP_DL_SUBDIR = python-pip
HOST_PYTHON3_PIP_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
