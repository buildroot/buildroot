################################################################################
#
# python-regex
#
################################################################################

PYTHON_REGEX_VERSION = 2023.12.25
PYTHON_REGEX_SOURCE = regex-$(PYTHON_REGEX_VERSION).tar.gz
PYTHON_REGEX_SITE = https://files.pythonhosted.org/packages/b5/39/31626e7e75b187fae7f121af3c538a991e725c744ac893cc2cfd70ce2853
PYTHON_REGEX_SETUP_TYPE = setuptools
PYTHON_REGEX_LICENSE = Apache-2.0
PYTHON_REGEX_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))
