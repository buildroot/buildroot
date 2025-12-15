################################################################################
#
# python-regex
#
################################################################################

PYTHON_REGEX_VERSION = 2025.11.3
PYTHON_REGEX_SOURCE = regex-$(PYTHON_REGEX_VERSION).tar.gz
PYTHON_REGEX_SITE = https://files.pythonhosted.org/packages/cc/a9/546676f25e573a4cf00fe8e119b78a37b6a8fe2dc95cda877b30889c9c45
PYTHON_REGEX_SETUP_TYPE = setuptools
PYTHON_REGEX_LICENSE = Apache-2.0
PYTHON_REGEX_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))
