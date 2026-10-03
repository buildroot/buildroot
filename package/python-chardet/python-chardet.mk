################################################################################
#
# python-chardet
#
################################################################################

PYTHON_CHARDET_VERSION = 7.6.0
PYTHON_CHARDET_SOURCE = chardet-$(PYTHON_CHARDET_VERSION).tar.gz
PYTHON_CHARDET_SITE = https://files.pythonhosted.org/packages/b1/51/cd61c567092a6cec796144510a68aff158ebfc1df82950a45bae65f28413
PYTHON_CHARDET_SETUP_TYPE = hatch
PYTHON_CHARDET_LICENSE = 0BSD
PYTHON_CHARDET_LICENSE_FILES = LICENSE
PYTHON_CHARDET_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
