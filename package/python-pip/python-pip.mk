################################################################################
#
# python-pip
#
################################################################################

PYTHON_PIP_VERSION = 23.0.1
PYTHON_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON_PIP_SITE = https://files.pythonhosted.org/packages/6b/8b/0b16094553ecc680e43ded8f920c3873b01b1da79a54274c98f08cb29fca
PYTHON_PIP_SETUP_TYPE = setuptools
PYTHON_PIP_LICENSE = MIT
PYTHON_PIP_LICENSE_FILES = LICENSE.txt
PYTHON_PIP_CPE_ID_VENDOR = pypa
PYTHON_PIP_CPE_ID_PRODUCT = pip

$(eval $(python-package))
