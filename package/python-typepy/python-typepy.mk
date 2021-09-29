################################################################################
#
# python-typepy
#
################################################################################

PYTHON_TYPEPY_VERSION = 1.1.5
PYTHON_TYPEPY_SOURCE = typepy-$(PYTHON_TYPEPY_VERSION).tar.gz
PYTHON_TYPEPY_SITE = https://files.pythonhosted.org/packages/08/c8/ebfa4381563f1946a7cd2b03fab14df641c3a9acf8e6ca5f5787dd1f735a
PYTHON_TYPEPY_SETUP_TYPE = setuptools
PYTHON_TYPEPY_LICENSE = MIT
PYTHON_TYPEPY_LICENSE_FILES = LICENSE

$(eval $(python-package))
