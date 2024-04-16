################################################################################
#
# python-bidict
#
################################################################################

PYTHON_BIDICT_VERSION = 0.22.1
PYTHON_BIDICT_SOURCE = bidict-$(PYTHON_BIDICT_VERSION).tar.gz
PYTHON_BIDICT_SITE = https://files.pythonhosted.org/packages/f2/be/b31e6ea9c94096a323e7a0e2c61480db01f07610bb7e7ea72a06fd1a23a8
PYTHON_BIDICT_SETUP_TYPE = setuptools
PYTHON_BIDICT_LICENSE = MPL-2.0
PYTHON_BIDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
