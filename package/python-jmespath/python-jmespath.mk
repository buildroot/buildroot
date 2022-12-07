################################################################################
#
# python-jmespath
#
################################################################################

PYTHON_JMESPATH_VERSION = 1.0.1
PYTHON_JMESPATH_SOURCE = jmespath-$(PYTHON_JMESPATH_VERSION).tar.gz
PYTHON_JMESPATH_SITE = https://files.pythonhosted.org/packages/00/2a/e867e8531cf3e36b41201936b7fa7ba7b5702dbef42922193f05c8976cd6
PYTHON_JMESPATH_SETUP_TYPE = setuptools
PYTHON_JMESPATH_LICENSE = MIT
PYTHON_JMESPATH_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
