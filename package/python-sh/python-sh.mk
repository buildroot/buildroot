################################################################################
#
# python-sh
#
################################################################################

PYTHON_SH_VERSION = 2.0.6
PYTHON_SH_SOURCE = sh-$(PYTHON_SH_VERSION).tar.gz
PYTHON_SH_SITE = https://files.pythonhosted.org/packages/cd/51/7355831d8e1cee8348157d769ccda8a31ca9fa0548e7f93d87837d83866d
PYTHON_SH_SETUP_TYPE = setuptools
PYTHON_SH_LICENSE = MIT
PYTHON_SH_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
