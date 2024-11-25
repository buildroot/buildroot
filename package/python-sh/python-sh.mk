################################################################################
#
# python-sh
#
################################################################################

PYTHON_SH_VERSION = 2.1.0
PYTHON_SH_SOURCE = sh-$(PYTHON_SH_VERSION).tar.gz
PYTHON_SH_SITE = https://files.pythonhosted.org/packages/52/12/b7965006c5adc57ba5459385358bd27c4983cd490884a75be86eb1d3efeb
PYTHON_SH_SETUP_TYPE = poetry
PYTHON_SH_LICENSE = MIT
PYTHON_SH_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
