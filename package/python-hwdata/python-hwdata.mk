################################################################################
#
# python-hwdata
#
################################################################################

PYTHON_HWDATA_VERSION = 2.4.1
PYTHON_HWDATA_SOURCE = hwdata-$(PYTHON_HWDATA_VERSION).tar.gz
PYTHON_HWDATA_SITE = https://files.pythonhosted.org/packages/ff/ec/4a6e57d765a63f7e9a8c5348f0bf3f7d39243dc5bc695fa1e887ca5856c8
PYTHON_HWDATA_SETUP_TYPE = setuptools
PYTHON_HWDATA_LICENSE = GPL-2.0+
PYTHON_HWDATA_LICENSE_FILES = LICENSE

$(eval $(python-package))
