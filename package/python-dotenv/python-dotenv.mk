################################################################################
#
# python-dotenv
#
################################################################################

PYTHON_DOTENV_VERSION = 1.1.0
PYTHON_DOTENV_SOURCE = python_dotenv-$(PYTHON_DOTENV_VERSION).tar.gz
PYTHON_DOTENV_SITE = https://files.pythonhosted.org/packages/88/2c/7bb1416c5620485aa793f2de31d3df393d3686aa8a8506d11e10e13c5baf
PYTHON_DOTENV_SETUP_TYPE = setuptools
PYTHON_DOTENV_LICENSE = BSD-3-Clause
PYTHON_DOTENV_LICENSE_FILES = LICENSE

$(eval $(python-package))
