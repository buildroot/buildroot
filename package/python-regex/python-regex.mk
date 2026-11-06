################################################################################
#
# python-regex
#
################################################################################

PYTHON_REGEX_VERSION = 2026.11.7
PYTHON_REGEX_SOURCE = regex-$(PYTHON_REGEX_VERSION).tar.gz
PYTHON_REGEX_SITE = https://files.pythonhosted.org/packages/f1/54/e3bf7a314a5e5d0bab5455cfcfc7634ca136fc8b249a7c15c829e88b00f2
PYTHON_REGEX_SETUP_TYPE = setuptools
PYTHON_REGEX_LICENSE = Apache-2.0
PYTHON_REGEX_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))
