################################################################################
#
# python-soupsieve
#
################################################################################

PYTHON_SOUPSIEVE_VERSION = 2.2.1
PYTHON_SOUPSIEVE_SOURCE = soupsieve-$(PYTHON_SOUPSIEVE_VERSION).tar.gz
PYTHON_SOUPSIEVE_SITE = https://files.pythonhosted.org/packages/c8/3f/e71d92e90771ac2d69986aa0e81cf0dfda6271e8483698f4847b861dd449
PYTHON_SOUPSIEVE_SETUP_TYPE = setuptools
PYTHON_SOUPSIEVE_LICENSE = MIT
PYTHON_SOUPSIEVE_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
