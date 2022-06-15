################################################################################
#
# python-xmltodict
#
################################################################################

PYTHON_XMLTODICT_VERSION = 0.13.0
PYTHON_XMLTODICT_SOURCE = xmltodict-$(PYTHON_XMLTODICT_VERSION).tar.gz
PYTHON_XMLTODICT_SITE = https://files.pythonhosted.org/packages/39/0d/40df5be1e684bbaecdb9d1e0e40d5d482465de6b00cbb92b84ee5d243c7f
PYTHON_XMLTODICT_SETUP_TYPE = setuptools
PYTHON_XMLTODICT_LICENSE = MIT
PYTHON_XMLTODICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
