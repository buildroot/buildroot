################################################################################
#
# python3-pip
#
################################################################################

# Please keep in sync with package/python-pip/python-pip.mk
PYTHON3_PIP_VERSION = 20.0.2
PYTHON3_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON3_PIP_SITE = https://files.pythonhosted.org/packages/8e/76/66066b7bc71817238924c7e4b448abdb17eb0c92d645769c223f9ace478f
PYTHON3_PIP_SETUP_TYPE = setuptools
PYTHON3_PIP_LICENSE = MIT
PYTHON3_PIP_LICENSE_FILES = LICENSE.txt
PYTHON3_PIP_CPE_ID_VENDOR = pypa
PYTHON3_PIP_CPE_ID_PRODUCT = pip
HOST_PYTHON3_PIP_DL_SUBDIR = python-pip
HOST_PYTHON3_PIP_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
