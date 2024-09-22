################################################################################
#
# python-typepy
#
################################################################################

PYTHON_TYPEPY_VERSION = 1.3.2
PYTHON_TYPEPY_SOURCE = typepy-$(PYTHON_TYPEPY_VERSION).tar.gz
PYTHON_TYPEPY_SITE = https://files.pythonhosted.org/packages/cc/86/9672794fb1c87a17b839666976ed4c8cb779ce05d471bed3166a39a53c4d
PYTHON_TYPEPY_SETUP_TYPE = setuptools
PYTHON_TYPEPY_LICENSE = MIT
PYTHON_TYPEPY_LICENSE_FILES = LICENSE

$(eval $(python-package))
