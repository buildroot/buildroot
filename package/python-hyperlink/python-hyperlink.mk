################################################################################
#
# python-hyperlink
#
################################################################################

PYTHON_HYPERLINK_VERSION = 21.0.0
PYTHON_HYPERLINK_SOURCE = hyperlink-$(PYTHON_HYPERLINK_VERSION).tar.gz
PYTHON_HYPERLINK_SITE = https://files.pythonhosted.org/packages/3a/51/1947bd81d75af87e3bb9e34593a4cf118115a8feb451ce7a69044ef1412e
PYTHON_HYPERLINK_SETUP_TYPE = setuptools
PYTHON_HYPERLINK_LICENSE = MIT
PYTHON_HYPERLINK_LICENSE_FILES = LICENSE

$(eval $(python-package))
