################################################################################
#
# python-types-setuptools
#
################################################################################

PYTHON_TYPES_SETUPTOOLS_VERSION = 84.0.0.20260812
PYTHON_TYPES_SETUPTOOLS_SOURCE = types_setuptools-$(PYTHON_TYPES_SETUPTOOLS_VERSION).tar.gz
PYTHON_TYPES_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/4f/cd/3b2a3362a526f91c33f785a291462b2ec448ae531101c62372fc30a21f53
PYTHON_TYPES_SETUPTOOLS_SETUP_TYPE = setuptools
PYTHON_TYPES_SETUPTOOLS_LICENSE = Apache-2.0
PYTHON_TYPES_SETUPTOOLS_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
