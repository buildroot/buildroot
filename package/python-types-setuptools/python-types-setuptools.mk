################################################################################
#
# python-types-setuptools
#
################################################################################

PYTHON_TYPES_SETUPTOOLS_VERSION = 80.9.0.20251223
PYTHON_TYPES_SETUPTOOLS_SOURCE = types_setuptools-$(PYTHON_TYPES_SETUPTOOLS_VERSION).tar.gz
PYTHON_TYPES_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/00/07/d1b605230730990de20477150191d6dccf6aecc037da94c9960a5d563bc8
PYTHON_TYPES_SETUPTOOLS_SETUP_TYPE = setuptools
PYTHON_TYPES_SETUPTOOLS_LICENSE = Apache-2.0
PYTHON_TYPES_SETUPTOOLS_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
