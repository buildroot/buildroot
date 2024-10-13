################################################################################
#
# python-xmltodict
#
################################################################################

PYTHON_XMLTODICT_VERSION = 0.14.1
PYTHON_XMLTODICT_SOURCE = xmltodict-$(PYTHON_XMLTODICT_VERSION).tar.gz
PYTHON_XMLTODICT_SITE = https://files.pythonhosted.org/packages/98/f7/d29b8cdc9d8d075673be0f800013c1161e2fd4234546a140855a1bcc9eb4
PYTHON_XMLTODICT_SETUP_TYPE = setuptools
PYTHON_XMLTODICT_LICENSE = MIT
PYTHON_XMLTODICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
