################################################################################
#
# python-xmltodict
#
################################################################################

PYTHON_XMLTODICT_VERSION = 1.0.4
PYTHON_XMLTODICT_SOURCE = xmltodict-$(PYTHON_XMLTODICT_VERSION).tar.gz
PYTHON_XMLTODICT_SITE = https://files.pythonhosted.org/packages/19/70/80f3b7c10d2630aa66414bf23d210386700aa390547278c789afa994fd7e
PYTHON_XMLTODICT_SETUP_TYPE = setuptools
PYTHON_XMLTODICT_LICENSE = MIT
PYTHON_XMLTODICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
