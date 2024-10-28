################################################################################
#
# python-xmltodict
#
################################################################################

PYTHON_XMLTODICT_VERSION = 0.14.2
PYTHON_XMLTODICT_SOURCE = xmltodict-$(PYTHON_XMLTODICT_VERSION).tar.gz
PYTHON_XMLTODICT_SITE = https://files.pythonhosted.org/packages/50/05/51dcca9a9bf5e1bce52582683ce50980bcadbc4fa5143b9f2b19ab99958f
PYTHON_XMLTODICT_SETUP_TYPE = setuptools
PYTHON_XMLTODICT_LICENSE = MIT
PYTHON_XMLTODICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
