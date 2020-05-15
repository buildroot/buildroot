################################################################################
#
# python-multidict
#
################################################################################

PYTHON_MULTIDICT_VERSION = 4.7.6
PYTHON_MULTIDICT_SOURCE = multidict-$(PYTHON_MULTIDICT_VERSION).tar.gz
PYTHON_MULTIDICT_SITE = https://files.pythonhosted.org/packages/65/d4/fabdcc5ee4451c8a8e177e27ddfd131a53a82ecc5a3b68468b7e9f8d70b4
PYTHON_MULTIDICT_SETUP_TYPE = setuptools
PYTHON_MULTIDICT_LICENSE = Apache-2.0
PYTHON_MULTIDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
