################################################################################
#
# python-channels
#
################################################################################

PYTHON_CHANNELS_VERSION = 4.3.1
PYTHON_CHANNELS_SOURCE = channels-$(PYTHON_CHANNELS_VERSION).tar.gz
PYTHON_CHANNELS_SITE = https://files.pythonhosted.org/packages/12/a0/46450fcf9e56af18a6b0440ba49db6635419bb7bc84142c35f4143b1a66c
PYTHON_CHANNELS_SETUP_TYPE = setuptools
PYTHON_CHANNELS_LICENSE = BSD-3-Clause
PYTHON_CHANNELS_LICENSE_FILES = LICENSE

$(eval $(python-package))
