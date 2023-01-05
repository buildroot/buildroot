################################################################################
#
# python-webargs
#
################################################################################

PYTHON_WEBARGS_VERSION = 8.2.0
PYTHON_WEBARGS_SOURCE = webargs-$(PYTHON_WEBARGS_VERSION).tar.gz
PYTHON_WEBARGS_SITE = https://files.pythonhosted.org/packages/4b/7d/fece8e6547b3edde8953b1c84a63da02e1a88efcb9d7d485e4d1b25d9c47
PYTHON_WEBARGS_SETUP_TYPE = setuptools
PYTHON_WEBARGS_LICENSE = MIT
PYTHON_WEBARGS_LICENSE_FILES = LICENSE

$(eval $(python-package))
