################################################################################
#
# python-async-generator
#
################################################################################

PYTHON_ASYNC_GENERATOR_VERSION = 1.10
PYTHON_ASYNC_GENERATOR_SOURCE = async_generator-$(PYTHON_ASYNC_GENERATOR_VERSION).tar.gz
PYTHON_ASYNC_GENERATOR_SITE = https://files.pythonhosted.org/packages/ce/b6/6fa6b3b598a03cba5e80f829e0dadbb49d7645f523d209b2fb7ea0bbb02a
PYTHON_ASYNC_GENERATOR_SETUP_TYPE = setuptools
PYTHON_ASYNC_GENERATOR_LICENSE = Apache-2.0 or MIT
PYTHON_ASYNC_GENERATOR_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
