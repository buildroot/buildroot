################################################################################
#
# python-channels
#
################################################################################

PYTHON_CHANNELS_VERSION = 4.1.0
PYTHON_CHANNELS_SOURCE = channels-$(PYTHON_CHANNELS_VERSION).tar.gz
PYTHON_CHANNELS_SITE = https://files.pythonhosted.org/packages/7d/73/da9e496657b242308d68cf79c937be125fcca4af61a620d98adfdde66fab
PYTHON_CHANNELS_SETUP_TYPE = setuptools
PYTHON_CHANNELS_LICENSE = BSD-3-Clause
PYTHON_CHANNELS_LICENSE_FILES = LICENSE

$(eval $(python-package))
