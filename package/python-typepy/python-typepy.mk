################################################################################
#
# python-typepy
#
################################################################################

PYTHON_TYPEPY_VERSION = 1.3.4
PYTHON_TYPEPY_SOURCE = typepy-$(PYTHON_TYPEPY_VERSION).tar.gz
PYTHON_TYPEPY_SITE = https://files.pythonhosted.org/packages/79/59/4c39942077d7de285f762a91024dbda731be693591732977358f77d120fb
PYTHON_TYPEPY_SETUP_TYPE = setuptools
PYTHON_TYPEPY_LICENSE = MIT
PYTHON_TYPEPY_LICENSE_FILES = LICENSE
PYTHON_TYPEPY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
