################################################################################
#
# python-iniconfig
#
################################################################################

PYTHON_INICONFIG_VERSION = 2.3.1
PYTHON_INICONFIG_SOURCE = iniconfig-$(PYTHON_INICONFIG_VERSION).tar.gz
PYTHON_INICONFIG_SITE = https://files.pythonhosted.org/packages/01/e1/2069291243c926a2ff1cd706c7f3eeb9b62144bf60f77c9fb9ff2fb26bd3
PYTHON_INICONFIG_SETUP_TYPE = setuptools
PYTHON_INICONFIG_LICENSE = MIT
PYTHON_INICONFIG_LICENSE_FILES = LICENSE
PYTHON_INICONFIG_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
