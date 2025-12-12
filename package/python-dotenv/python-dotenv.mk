################################################################################
#
# python-dotenv
#
################################################################################

PYTHON_DOTENV_VERSION = 1.2.1
PYTHON_DOTENV_SOURCE = python_dotenv-$(PYTHON_DOTENV_VERSION).tar.gz
PYTHON_DOTENV_SITE = https://files.pythonhosted.org/packages/f0/26/19cadc79a718c5edbec86fd4919a6b6d3f681039a2f6d66d14be94e75fb9
PYTHON_DOTENV_SETUP_TYPE = setuptools
PYTHON_DOTENV_LICENSE = BSD-3-Clause
PYTHON_DOTENV_LICENSE_FILES = LICENSE

$(eval $(python-package))
