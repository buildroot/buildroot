################################################################################
#
# python-regex
#
################################################################################

PYTHON_REGEX_VERSION = 2026.2.28
PYTHON_REGEX_SOURCE = regex-$(PYTHON_REGEX_VERSION).tar.gz
PYTHON_REGEX_SITE = https://files.pythonhosted.org/packages/8b/71/41455aa99a5a5ac1eaf311f5d8efd9ce6433c03ac1e0962de163350d0d97
PYTHON_REGEX_SETUP_TYPE = setuptools
PYTHON_REGEX_LICENSE = Apache-2.0
PYTHON_REGEX_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))
