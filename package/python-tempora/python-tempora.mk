################################################################################
#
# python-tempora
#
################################################################################

PYTHON_TEMPORA_VERSION = 5.8.0
PYTHON_TEMPORA_SOURCE = tempora-$(PYTHON_TEMPORA_VERSION).tar.gz
PYTHON_TEMPORA_SITE = https://files.pythonhosted.org/packages/c3/f2/bbd6d2178791eaf8bac06857cb0ee39840e69f7b64ecb0c414bf8f46daff
PYTHON_TEMPORA_LICENSE = MIT
PYTHON_TEMPORA_LICENSE_FILES = LICENSE
PYTHON_TEMPORA_SETUP_TYPE = setuptools
PYTHON_TEMPORA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
