################################################################################
#
# python-channels
#
################################################################################

PYTHON_CHANNELS_VERSION = 4.2.0
PYTHON_CHANNELS_SOURCE = channels-$(PYTHON_CHANNELS_VERSION).tar.gz
PYTHON_CHANNELS_SITE = https://files.pythonhosted.org/packages/96/e2/10d949dca9eb8a85c5735efefe3309033419e7d4f4193a70f6ede58b2951
PYTHON_CHANNELS_SETUP_TYPE = setuptools
PYTHON_CHANNELS_LICENSE = BSD-3-Clause
PYTHON_CHANNELS_LICENSE_FILES = LICENSE

$(eval $(python-package))
