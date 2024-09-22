################################################################################
#
# python-sh
#
################################################################################

PYTHON_SH_VERSION = 2.0.7
PYTHON_SH_SOURCE = sh-$(PYTHON_SH_VERSION).tar.gz
PYTHON_SH_SITE = https://files.pythonhosted.org/packages/14/7a/5148402146d360a6d15922814a3b065b52be3a5fe878a8834d3ce4e7d33f
PYTHON_SH_SETUP_TYPE = pep517
PYTHON_SH_LICENSE = MIT
PYTHON_SH_LICENSE_FILES = LICENSE.txt
PYTHON_SH_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))
