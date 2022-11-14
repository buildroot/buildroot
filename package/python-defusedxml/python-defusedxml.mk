################################################################################
#
# python-defusedxml
#
################################################################################

PYTHON_DEFUSEDXML_VERSION = 0.7.1
PYTHON_DEFUSEDXML_SOURCE = defusedxml-$(PYTHON_DEFUSEDXML_VERSION).tar.gz
PYTHON_DEFUSEDXML_SITE = https://files.pythonhosted.org/packages/0f/d5/c66da9b79e5bdb124974bfe172b4daf3c984ebd9c2a06e2b8a4dc7331c72
PYTHON_DEFUSEDXML_SETUP_TYPE = setuptools
PYTHON_DEFUSEDXML_LICENSE = Python-2.0
PYTHON_DEFUSEDXML_LICENSE_FILES = LICENSE

$(eval $(python-package))
