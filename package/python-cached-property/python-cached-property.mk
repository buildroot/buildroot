################################################################################
#
# python-cached-property
#
################################################################################

PYTHON_CACHED_PROPERTY_VERSION = 1.5.2
PYTHON_CACHED_PROPERTY_SOURCE = cached-property-$(PYTHON_CACHED_PROPERTY_VERSION).tar.gz
PYTHON_CACHED_PROPERTY_SITE = https://files.pythonhosted.org/packages/61/2c/d21c1c23c2895c091fa7a91a54b6872098fea913526932d21902088a7c41
PYTHON_CACHED_PROPERTY_SETUP_TYPE = setuptools
PYTHON_CACHED_PROPERTY_LICENSE = BSD-3-Clause
PYTHON_CACHED_PROPERTY_LICENSE_FILES = LICENSE

$(eval $(python-package))
