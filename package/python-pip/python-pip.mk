################################################################################
#
# python-pip
#
################################################################################

PYTHON_PIP_VERSION = 22.3
PYTHON_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON_PIP_SITE = https://files.pythonhosted.org/packages/f8/08/7f92782ff571c7c7cb6c5eeb8ebbb1f68cb02bdb24e55c5de4dd9ce98bc3
PYTHON_PIP_SETUP_TYPE = setuptools
PYTHON_PIP_LICENSE = MIT
PYTHON_PIP_LICENSE_FILES = LICENSE.txt
PYTHON_PIP_CPE_ID_VENDOR = pypa
PYTHON_PIP_CPE_ID_PRODUCT = pip

$(eval $(python-package))
