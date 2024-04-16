################################################################################
#
# python-iniconfig
#
################################################################################

PYTHON_INICONFIG_VERSION = 2.0.0
PYTHON_INICONFIG_SOURCE = iniconfig-$(PYTHON_INICONFIG_VERSION).tar.gz
PYTHON_INICONFIG_SITE = https://files.pythonhosted.org/packages/d7/4b/cbd8e699e64a6f16ca3a8220661b5f83792b3017d0f79807cb8708d33913
PYTHON_INICONFIG_SETUP_TYPE = pep517
PYTHON_INICONFIG_LICENSE = MIT
PYTHON_INICONFIG_LICENSE_FILES = LICENSE
PYTHON_INICONFIG_DEPENDENCIES = host-python-hatchling host-python-hatch-vcs

$(eval $(python-package))
