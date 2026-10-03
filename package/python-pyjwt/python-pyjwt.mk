################################################################################
#
# python-pyjwt
#
################################################################################

PYTHON_PYJWT_VERSION = 2.15.1
PYTHON_PYJWT_SOURCE = pyjwt-$(PYTHON_PYJWT_VERSION).tar.gz
PYTHON_PYJWT_SITE = https://files.pythonhosted.org/packages/43/ea/5194e52748b0da83d71e082d75496eaec6e58f419f5e184786ded517e6a9
PYTHON_PYJWT_SETUP_TYPE = setuptools
PYTHON_PYJWT_LICENSE = MIT
PYTHON_PYJWT_LICENSE_FILES = LICENSE
PYTHON_PYJWT_CPE_ID_VENDOR = pyjwt_project
PYTHON_PYJWT_CPE_ID_PRODUCT = pyjwt

$(eval $(python-package))
