################################################################################
#
# python-iniconfig
#
################################################################################

PYTHON_INICONFIG_VERSION = 2.1.0
PYTHON_INICONFIG_SOURCE = iniconfig-$(PYTHON_INICONFIG_VERSION).tar.gz
PYTHON_INICONFIG_SITE = https://files.pythonhosted.org/packages/f2/97/ebf4da567aa6827c909642694d71c9fcf53e5b504f2d96afea02718862f3
PYTHON_INICONFIG_SETUP_TYPE = hatch
PYTHON_INICONFIG_LICENSE = MIT
PYTHON_INICONFIG_LICENSE_FILES = LICENSE
PYTHON_INICONFIG_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
