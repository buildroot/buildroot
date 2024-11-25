################################################################################
#
# python-cached-property
#
################################################################################

PYTHON_CACHED_PROPERTY_VERSION = 2.0.1
PYTHON_CACHED_PROPERTY_SOURCE = cached_property-$(PYTHON_CACHED_PROPERTY_VERSION).tar.gz
PYTHON_CACHED_PROPERTY_SITE = https://files.pythonhosted.org/packages/76/4b/3d870836119dbe9a5e3c9a61af8cc1a8b69d75aea564572e385882d5aefb
PYTHON_CACHED_PROPERTY_SETUP_TYPE = setuptools
PYTHON_CACHED_PROPERTY_LICENSE = BSD-3-Clause
PYTHON_CACHED_PROPERTY_LICENSE_FILES = LICENSE

$(eval $(python-package))
