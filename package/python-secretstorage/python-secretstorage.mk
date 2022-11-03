################################################################################
#
# python-secretstorage
#
################################################################################

PYTHON_SECRETSTORAGE_VERSION = 3.3.3
PYTHON_SECRETSTORAGE_SOURCE = SecretStorage-$(PYTHON_SECRETSTORAGE_VERSION).tar.gz
PYTHON_SECRETSTORAGE_SITE = https://files.pythonhosted.org/packages/53/a4/f48c9d79cb507ed1373477dbceaba7401fd8a23af63b837fa61f1dcd3691
PYTHON_SECRETSTORAGE_SETUP_TYPE = setuptools
PYTHON_SECRETSTORAGE_LICENSE = BSD-3-Clause
PYTHON_SECRETSTORAGE_LICENSE_FILES = LICENSE

$(eval $(python-package))
