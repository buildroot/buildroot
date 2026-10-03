################################################################################
#
# python-psygnal
#
################################################################################

PYTHON_PSYGNAL_VERSION = 0.16.1
PYTHON_PSYGNAL_SOURCE = psygnal-$(PYTHON_PSYGNAL_VERSION).tar.gz
PYTHON_PSYGNAL_SITE = https://files.pythonhosted.org/packages/75/df/2a94607af05d91638646339acfc02d7c865821c21356ddcfef3d6b4c7fb6
PYTHON_PSYGNAL_SETUP_TYPE = hatch
PYTHON_PSYGNAL_LICENSE = BSD-3-Clause
PYTHON_PSYGNAL_LICENSE_FILES = LICENSE
PYTHON_PSYGNAL_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
