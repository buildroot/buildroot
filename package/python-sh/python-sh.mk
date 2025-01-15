################################################################################
#
# python-sh
#
################################################################################

PYTHON_SH_VERSION = 2.2.1
PYTHON_SH_SOURCE = sh-$(PYTHON_SH_VERSION).tar.gz
PYTHON_SH_SITE = https://files.pythonhosted.org/packages/bd/30/abf254f7b56ba7bcae938767e3ee0f54d220d931a35a8721de350b76dec5
PYTHON_SH_SETUP_TYPE = poetry
PYTHON_SH_LICENSE = MIT
PYTHON_SH_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
