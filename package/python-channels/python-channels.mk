################################################################################
#
# python-channels
#
################################################################################

PYTHON_CHANNELS_VERSION = 4.0.0
PYTHON_CHANNELS_SOURCE = channels-$(PYTHON_CHANNELS_VERSION).tar.gz
PYTHON_CHANNELS_SITE = https://files.pythonhosted.org/packages/8e/cb/6fedd9df5972b893a04c8e5d7748873d6480a813e74b0797945bee1f4282
PYTHON_CHANNELS_SETUP_TYPE = setuptools
PYTHON_CHANNELS_LICENSE = BSD-3-Clause
PYTHON_CHANNELS_LICENSE_FILES = LICENSE

$(eval $(python-package))
