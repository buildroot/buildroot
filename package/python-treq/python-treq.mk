################################################################################
#
# python-treq
#
################################################################################

PYTHON_TREQ_VERSION = 24.9.1
PYTHON_TREQ_SOURCE = treq-$(PYTHON_TREQ_VERSION).tar.gz
PYTHON_TREQ_SITE = https://files.pythonhosted.org/packages/08/94/424f3bb11eaf464880d076cca2e9d0ee21a1be805fe9761b87eccba5b3ae
PYTHON_TREQ_LICENSE = MIT
PYTHON_TREQ_LICENSE_FILES = LICENSE
PYTHON_TREQ_SETUP_TYPE = setuptools
PYTHON_TREQ_DEPENDENCIES = host-python-incremental

$(eval $(python-package))
