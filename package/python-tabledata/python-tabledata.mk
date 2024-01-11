################################################################################
#
# python-tabledata
#
################################################################################

PYTHON_TABLEDATA_VERSION = 1.3.3
PYTHON_TABLEDATA_SOURCE = tabledata-$(PYTHON_TABLEDATA_VERSION).tar.gz
PYTHON_TABLEDATA_SITE = https://files.pythonhosted.org/packages/48/6a/7f78fbf883f325b70ba9ce5c10d97652f5c371e224940097c2cea9d0f456
PYTHON_TABLEDATA_SETUP_TYPE = setuptools
PYTHON_TABLEDATA_LICENSE = MIT
PYTHON_TABLEDATA_LICENSE_FILES = LICENSE

$(eval $(python-package))
