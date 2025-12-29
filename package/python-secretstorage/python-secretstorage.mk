################################################################################
#
# python-secretstorage
#
################################################################################

PYTHON_SECRETSTORAGE_VERSION = 3.5.0
PYTHON_SECRETSTORAGE_SOURCE = secretstorage-$(PYTHON_SECRETSTORAGE_VERSION).tar.gz
PYTHON_SECRETSTORAGE_SITE = https://files.pythonhosted.org/packages/1c/03/e834bcd866f2f8a49a85eaff47340affa3bfa391ee9912a952a1faa68c7b
PYTHON_SECRETSTORAGE_SETUP_TYPE = setuptools
PYTHON_SECRETSTORAGE_LICENSE = BSD-3-Clause
PYTHON_SECRETSTORAGE_LICENSE_FILES = LICENSE

$(eval $(python-package))
