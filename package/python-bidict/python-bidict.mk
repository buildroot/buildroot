################################################################################
#
# python-bidict
#
################################################################################

PYTHON_BIDICT_VERSION = 0.21.3
PYTHON_BIDICT_SOURCE = bidict-$(PYTHON_BIDICT_VERSION).tar.gz
PYTHON_BIDICT_SITE = https://files.pythonhosted.org/packages/3f/81/7221b28d692af5c5fc180c4850b8e4a48c7db92b3d529b430488f67db74f
PYTHON_BIDICT_SETUP_TYPE = setuptools
PYTHON_BIDICT_LICENSE = MPL-2.0
PYTHON_BIDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
