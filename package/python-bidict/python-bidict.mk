################################################################################
#
# python-bidict
#
################################################################################

PYTHON_BIDICT_VERSION = 0.22.0
PYTHON_BIDICT_SOURCE = bidict-$(PYTHON_BIDICT_VERSION).tar.gz
PYTHON_BIDICT_SITE = https://files.pythonhosted.org/packages/2b/84/159749556b9c49ea4489dadeb94d44f05d6033d1db3af4c83120ecac5b15
PYTHON_BIDICT_SETUP_TYPE = setuptools
PYTHON_BIDICT_LICENSE = MPL-2.0
PYTHON_BIDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
