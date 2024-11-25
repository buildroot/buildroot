################################################################################
#
# python-bidict
#
################################################################################

PYTHON_BIDICT_VERSION = 0.23.1
PYTHON_BIDICT_SOURCE = bidict-$(PYTHON_BIDICT_VERSION).tar.gz
PYTHON_BIDICT_SITE = https://files.pythonhosted.org/packages/9a/6e/026678aa5a830e07cd9498a05d3e7e650a4f56a42f267a53d22bcda1bdc9
PYTHON_BIDICT_SETUP_TYPE = setuptools
PYTHON_BIDICT_LICENSE = MPL-2.0
PYTHON_BIDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
