################################################################################
#
# python-sh
#
################################################################################

PYTHON_SH_VERSION = 2.4.0
PYTHON_SH_SOURCE = sh-$(PYTHON_SH_VERSION).tar.gz
PYTHON_SH_SITE = https://files.pythonhosted.org/packages/e9/c8/137093889a8b8c9a66c9b46079cf2a0e155a8be027df212a4041e3b7b09c
PYTHON_SH_SETUP_TYPE = hatch
PYTHON_SH_LICENSE = MIT
PYTHON_SH_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
