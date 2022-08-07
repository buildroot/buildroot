################################################################################
#
# python-appdirs
#
################################################################################

PYTHON_APPDIRS_VERSION = 1.4.4
PYTHON_APPDIRS_SOURCE = appdirs-$(PYTHON_APPDIRS_VERSION).tar.gz
PYTHON_APPDIRS_SITE = https://files.pythonhosted.org/packages/d7/d8/05696357e0311f5b5c316d7b95f46c669dd9c15aaeecbb48c7d0aeb88c40
PYTHON_APPDIRS_SETUP_TYPE = setuptools
PYTHON_APPDIRS_LICENSE = MIT
PYTHON_APPDIRS_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
